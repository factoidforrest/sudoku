define ["jquery", "libs/sudokugen"], ($) ->
	class Game
		selected: null

		constructor: ->
			@sudoku = new Sudoku
			@sudoku.level = $('.difficulty').children('.active').attr('data-diff')
			this.newGame()

		newGame: ->
			@sudoku._newGame()
			this.render()     
			this.registerListeners()

		render: ->
			for num, i in @sudoku.matrix
				box = $('.box_' + i)
				if num != 0
					box.children('span').text(num)
					box.addClass("fixed")
				else  
					box.addClass("editable")
					box.children('span').text("")

		removeListeners: =>
			$(document).unbind('keypress')
			$('.editable').unbind('click')
			$('.board').unbind('click')
			$('.diff-setting').unbind('click')
			$('.active').unbind('click')
			@selected = null

		registerListeners: ->
			self = this
			$(document).on 'keypress', (e) ->
				pressed = String.fromCharCode(e.charCode) 
				#if user entered a number
				num = parseInt(pressed)
				if !isNaN(num) and (num != 0)
					self.playIfPossible(num, self.selected)

			$('.editable').on 'click', () ->
				self.handleClick(this)

			#user chooses a number with the mouse
			$('.selection').on 'click', '.active', () ->
				num = parseInt($(this).attr('data-choice'))
				self.playIfPossible(num, self.selected)

			$('.diff-setting').on 'click', () ->
				$('.diff-setting.active').removeClass('active')
				$(this).addClass('active')
				self.clean()
				self.newGame()

		playIfPossible: (num, index) ->
			[row, col] = @indexToCoords(index)
			valid = @sudoku.checkVal(row, col, num)
			if valid
				@sudoku.setVal(row, col, num)
				$('.box_' + index).children('span').text(num)
				self.selected = null
				#clear number choice box
				$('.selection').children('.active').removeClass('active')
				$('.selected').removeClass('selected')
				if @sudoku.gameFinished()
					$('.win-dialog').css('visibility', 'visible')
					$('.innerwrap').addClass('finished')
					$('.board').click =>
						@clean()
						@newGame()

			else
				$('.box_' + @selected).addClass('wrong')
				setTimeout( () ->
					$('.wrong').removeClass('wrong')
				, 1000)

		handleClick: (clicked) ->
			if $(clicked).hasClass('selected')
				unselecting = true
			else
				unselecting = false
			$('.selected').removeClass('selected')
			if unselecting
				@selected = null
				$('.selection').children('.active').removeClass('active')
			else
				$(clicked).addClass('selected')
				@selected = parseInt($(clicked).attr('data-box'))
				contents = $(clicked).children('span')
				#clear it if it was holding something. this is how delete works
				if contents.text() != ''
					contents.text('')
					@sudoku.setVal(@indexToCoords(@selected)..., 0)
				@showAvailable(@selected)

		showAvailable: (selected) ->
			available = []
			@sudoku.getAvailable(@sudoku.matrix, @selected, available)
			$('.choice').removeClass('active')
			for num in available
				$('.choice_' + num).addClass('active')

		clean: () =>
			@removeListeners()
			$('.selected').removeClass('selected')
			$('.finished').removeClass('finished')
			$('.fixed').removeClass("fixed")
			$('.editable').removeClass("editable")
			$('.win-dialog').css('visibility', 'hidden')

		indexToCoords: (i) ->
			col = i % 9
			row = (i - col) / 9 
			return [row, col]


	return Game




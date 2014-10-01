define ["jquery", "libs/sudokugen"], ($) ->
	class Game
		selected: null

		constructor: ->
			@sudoku = new Sudoku
			@sudoku.level = $('.difficulty').children('.active').attr('data-diff')
			this.newGame()
			console.log(@sudoku.matrix)
	
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

		removeListeners: ->
			$(document).unbind('keypress')
			$('.editable').unbind('click')
			$('.finished').unbind('click')
			$('.diff-setting').unbind('click')

		registerListeners: ->
			self = this
			$(document).on 'keypress', (e) ->
				console.log("key pressed")
				console.log(e)
				pressed = String.fromCharCode(e.charCode) 
				console.log("user pressed " + pressed)
				#if user entered a number
				if !isNaN(pressed) 
					num = parseInt(pressed)
					if (num != 0)
						self.playIfPossible(num, self.selected)

			$('.editable').on 'click', (e) ->
				console.log("clicked")

				console.log($(this).attr('data-box'))
				if $(this).hasClass('selected')
					unselecting = true
				else
					unselecting = false
				$('.selected').removeClass('selected')
				if unselecting
					self.selected = null
				else
					console.log("selecting")
					$(this).addClass('selected')
					self.selected = parseInt($(this).attr('data-box'))
					contents = $(this).children('span')
					#clear it if it was holding something. this is how delete works
					if contents.text() != ''
						contents.text('')
						self.sudoku.setVal(self.indexToCoords(self.selected)..., 0)

			$('.board').on 'click', '.finished', =>
				console.log("resetting")
				@clean()
				@newGame()

			$('.diff-setting').on 'click', () ->
				console.log('difficulty changed')
				$('.diff-setting.active').removeClass('active')
				$(this).addClass('active')
				self.clean()
				self.newGame()

		playIfPossible: (num, index) ->
			[row, col] = @indexToCoords(index)
			console.log("row is "+ row + " and col is " + col)
			valid = @sudoku.checkVal(row, col, num)
			console.log("legal move? " + valid)
			if valid
				@sudoku.setVal(row, col, num)
				$('.box_' + index).children('span').text(num)
				self.selected = null
				$('.selected').removeClass('selected')
				if @sudoku.gameFinished()
					$('.win-dialog').css('visibility', 'visible')
					$('.innerwrap').addClass('finished').click =>
						@newGame()

		clean: () =>
			@removeListeners()
			$('.finished').removeClass('finished')
			$('.fixed').removeClass("fixed")
			$('.editable').removeClass("editable")
			$('.win-dialog').css('visibility', 'hidden')

		indexToCoords: (i) ->
			col = i % 9
			row = (i - col) / 9 
			return [row, col]


	return Game




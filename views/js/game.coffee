define ["jquery", "libs/sudokugen"], ($) ->
	class Game
		selected: null

		constructor: ->
			@sudoku = new Sudoku
			@sudoku.level = 2
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

		registerListeners: ->
			self = this
			$(document).keypress (e) ->
				console.log("key pressed")
				console.log(e)
				pressed = String.fromCharCode(e.charCode) 
				console.log("user pressed " + pressed)
				#if user entered a number
				if !isNaN(pressed) 
					num = parseInt(pressed)
					if (num != 0)
						playIfPossible(num, self.selected)

			$('.editable').click (e) ->
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


	return Game

playIfPossible = (num, index) ->
	col = index % 9
	row = (index - col) / 9 
	console.log("row is "+ row + " and col is " + col)

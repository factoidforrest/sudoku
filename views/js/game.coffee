define ["jquery", "libs/sudokugen"], ($) ->
	class Game
		constructor: ->
			@sudoku = new Sudoku
			@sudoku.level = 1
			this.newGame()
			console.log(@sudoku.matrix)

		newGame: ->
			@sudoku._newGame()
			this.render()
		render: ->
			for num, i in @sudoku.matrix
				box = $('.box_' + i)
				if num != 0
					box.children('span').text(num)
					box.addClass("fixed")
				else	
					box.addClass("editable")


	return Game
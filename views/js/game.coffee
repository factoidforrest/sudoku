define ["jquery", "libs/sudokugen"], ($) ->
	class Game
		constructor: ->
			@sudoku = new Sudoku
			@sudoku.level = 1
			@sudoku.newGame()
			console.log(@sudoku.matrix)

	return Game
###
UberSudoku
v0.0
Copyright (c) 2014, Forrest I. Allison

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
###

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
			unselecting = $(clicked).hasClass('selected')
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




sudoku
======

### About

This sudoku webapp uses node and coffeescript on the server with jade and sass templates.  The client side uses jQuery.
Live demo: http://ubersudoku.herokuapp.com/

### Development Setup

Install npm and node. 
Enter project directory and run 

`npm install`

Start the server with 

`coffee server.coffee`

You may also want to install nodemon to watch the project changes and restart the server automatically, by running

`npm install nodemon -g`

`nodemon server.coffee`

You should be good to go!  

###Structure

#####Server
The server lives in server.coffee in the root project directory.  It takes care of serving assets and compiling them if necessary.  The views folder contains assets which compile into the public directory.  The Public folder holds assets which do not need to be compiled and are served directly by the node static asset server.  

#####Client
Requirejs manages asynchronous javascript loading.  The main initializer is found in /views/js/main.coffee

A library from http://blog.fourthwoods.com/2011/02/05/sudoku-in-javascript/ controls game logic. It generates sudoku games using a shuffle algorithm which starts with a known board and shuffles it.  It then removes random numbers but ensures that only a single solution remains.  A slightly modified copy of the library lives in /public/libs/sudokugen.js.  

/views/js/game.coffee manages the interface and its connection to the game library.  

###Description of rules and todo

http://ubersudoku.herokuapp.com/about

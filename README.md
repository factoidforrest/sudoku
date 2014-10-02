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
The server lives in server.coffee in the root project directory.  It takes care of serving assets and compiling them if necessary.  The views folder contains assets which compile into the public directory.  Public holds assets which do not need to be compiled and are served directly by the node static asset server.  

#####Client
The client relies on a 

###Description of rules 

http://ubersudoku.herokuapp.com/about

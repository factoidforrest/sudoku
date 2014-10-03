
requirejs.config
  paths:
    
    # Load jquery from google cdn. On fail, load local file. 
    jquery: [["//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min"], "libs/jquery-min"]

    # Load bootstrap from cdn. On fail, load local file. 
    # bootstrap: [["//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min"], "libs/bootstrap-min"]

  #shim:
    
  # Set bootstrap dependencies (just jQuery) 
  # bootstrap: ["jquery"]

require [
  "jquery"
  "game"
], ($, Game) -> 
  if $('.board').length > 0
    #put it in the global namespace for easy debugging
    window.game = new Game()
    
  
  
  
  

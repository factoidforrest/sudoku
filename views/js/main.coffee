
requirejs.config

  paths:
    
    # Load jquery from google cdn. On fail, load local file. 
    jquery: ["//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min"]#, "libs/jquery-min"]
    
    # Load bootstrap from cdn. On fail, load local file. 
    bootstrap: ["//netdna.bootstrapcdn.com/bootstrap/3.0.2/js/bootstrap.min"]#, "libs/bootstrap-min"]

  shim:
    
    # Set bootstrap dependencies (just jQuery) 
    bootstrap: ["jquery"]

require [
  "jquery"
  "bootstrap"
], ($) -> {
  #console.log "Requirejs finished load"
  # {}
}
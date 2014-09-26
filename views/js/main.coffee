
requirejs.config
  paths:
    
    # Load jquery from google cdn. On fail, load local file. 
    jquery: ["//code.jquery.com/jquery-migrate-1.2.1.min.js"], "libs/jquery-min"]
    
    # Load bootstrap from cdn. On fail, load local file. 
    bootstrap: ["//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"], "libs/bootstrap-min"]

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
requirejs.config({
  paths: {
    jquery: ["//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min"],
    bootstrap: ["//netdna.bootstrapcdn.com/bootstrap/3.0.2/js/bootstrap.min"]
  },
  shim: {
    bootstrap: ["jquery"]
  }
});

require(["jquery", "bootstrap"], function($) {
  return {};
});

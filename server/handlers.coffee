##sass = require('node-sass')
##fs = require('fs')
aDay = 86400000;
staticOpts = {maxAge: aDay}

module.exports = {
	root: (req, res) ->
		section = req.param "section"
		section ||= "play"
		res.render('root.jade', {section: section})
  }
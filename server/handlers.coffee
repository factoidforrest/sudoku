sass = require('node-sass')
fs = require('fs')
aDay = 86400000;
staticOpts = {maxAge: aDay}

### this works fine but doesn't update on file change, may as well use middleware instead
built = {}

build = (path, data) ->
	cached = built[path]

	if !cached
		template = fs.readFileSync(path, 'utf8')
		extension = path.split('.')[1]
		if extension == 'haml'
			compiled = haml.render(template, {locals: data})
		else if extension == 'scss'
			compiled = sass.renderSync({data: template})
		else
			throw Error.new('unrecognized extension requested')
		built[path] = compiled
		console.log('compiled file for ', path, compiled)
	else
		compiled = cached
	return compiled
###
module.exports = {
	root: (req, res) ->
		res.render('root.jade')
		###
		html = build('public/layout.haml', null)
		res.send(html)
		###
  }
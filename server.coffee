
express = require('express')
app = express()
coffeescript = require('connect-coffee-script')
handlers = require('./server/handlers')
sass = require('node-sass')
path = require('path')
favicon = require('serve-favicon')

production = process.env.PRODUCTION == 'true'

app.use(express.compress())
app.set('views', __dirname + '/views')
app.use(express.logger())
app.use(favicon(path.join(__dirname,'public','images','favicon.ico')))
app.locals.uglify = production

app.set('view engine', 'jade')

app.use(sass.middleware({
  src: __dirname + '/views/stylesheets',
  dest: __dirname + '/public',
  debug: !production,
  outputStyle: if production then 'compressed' else 'nested'
}))

#TODO: switch to a compiler with compression support
app.use(coffeescript({
  src: __dirname + '/views/js',
  dest: __dirname + '/public',
  bare: true,
  compress: production
}))

if production
	cachetime = 86400000
else
	cachetime = 0

#static assets
app.use(express.static(__dirname + '/public', { maxAge: cachetime }))

#static file routes
app.get('/:section?', handlers.root)

app.listen(process.env.PORT || 3000)


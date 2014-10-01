
express = require('express')
app = express()
coffeescript = require('connect-coffee-script')
handlers = require('./server/handlers')
sass = require('node-sass')

production = if process.env.PRODUCTION == 'true' then true else false

app.use(express.compress())
app.set('views', __dirname + '/views')
app.use(express.logger())

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

#static assets
app.use(express.static(__dirname + '/public'))

#static file routes
app.get('/:section?', handlers.root)

app.listen(process.env.PORT || 3000)


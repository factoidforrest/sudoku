
express = require('express')
app = express()
coffeescript = require('connect-coffee-script')
handlers = require('./server/handlers')
sass = require('node-sass')

app.set('views', __dirname + '/views')
app.use(express.logger())

app.locals.uglify = false

app.set('view engine', 'jade')

app.use(sass.middleware({
    src: __dirname + '/views/stylesheets',
    dest: __dirname + '/public',
    debug: true#,
    #outputStyle: 'compressed'
}))


app.use(coffeescript({
  src: __dirname + '/views/js',
  dest: __dirname + '/public',
  force: true,
  bare: true
}))

#static assets
app.use(express.static(__dirname + '/public'))

#static file routes
app.get('/', handlers.root)

app.listen(process.env.PORT || 3000)


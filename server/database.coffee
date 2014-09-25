mysql = require 'mysql'
async = require 'asyn'

class Database
  #Queue
  Q = []
  handleDisconnect: =>
    self = this
    @connection = mysql.createConnection(@options) # Recreate the connection, since
    # the old one cannot be reused.
    @connection.connect (err) -> # The server is either down
      if err # or restarting (takes a while sometimes).
        console.log "error when connecting to db, retrying:", err
        setTimeout self.handleDisconnect, 2000 
      else
        if self.Q.length > 0
          tasks = self.Q
          self.Q = []
          async.task tasks, (err, results) ->
            console.log('restarted %s backlogged tasks', results.length)
        console.log("database connected")
        
    # We introduce a delay before attempting to reconnect,
    # to avoid a hot loop, and to allow our node script to
    # process asynchronous requests in the meantime.
    # If you're also serving http, display a 503 error.
    @connection.on "error", (err) ->
      console.log "db error", err
      if err.code is "PROTOCOL_CONNECTION_LOST" # Connection to the MySQL server is usually
        self.handleDisconnect() # lost due to either server restart, or a
      else # connnection idle timeout (the wait_timeout
        throw err # server variable configures this)

  #passes usable db object into the callback
  connection: (callback) => 
    if @connection.status == 'connected'
      callback(null, @connection)
    else
      console.log("ATTEMPTED TO USE DISCONNECTED DB, queueing request")
      #untested
      this.Q.push (cb) -> 
        callback(null, @connection)
        cb()



  constructor: (app)->
    self = this
    app.configure 'development', ->
      self.options = 
        host: 'localhost',
        user: 'forrest'
    app.configure 'production', ->
      throw new Error("database not yet setup for production")
    @handleDisconnect()


module.exports = Database
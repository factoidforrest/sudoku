Sequelize = require 'sequelize'
path = require 'path'


class ORM
  constructor: (app) ->
    config = null
    app.configure 'development', ->
      config = 
        user: 'forrest',
        db: 'test'
    app.configure 'production', ->
      throw new Error("database not yet setup for production")
    sequelize = new Sequelize config.db, config.user #, {
      #pool: { maxConnections: 5, maxIdleTime: 30}
    #}
    models = {}
    ['user','comment'].forEach (modelName) ->
      model = sequelize.import(path.join(__dirname, '/models/', modelName))
      models[model.name] = model

    for k, model of models 
      model.associate(models) if model.hasOwnProperty('associate')
      #bind them onto the sequelize object
      sequelize[model.name] = model
    return sequelize

    
#would like to think of a cleaner way to do this
cached = null
module.exports = (app) ->
  if cached
    assert(cached != null)
    return cached
  else 
    return cached = new ORM(app)
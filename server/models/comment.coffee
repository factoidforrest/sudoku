
module.exports = (sequelize, DataTypes) ->
	Comment = sequelize.define('Comment', {
		body: DataTypes.STRING
	},
	{classMethods: 
		associate: (models) ->
			Comment.belongsTo(models.User)
	})
	return Comment
	
module.exports = (sequelize, DataTypes) ->
	User = sequelize.define('User', {
		user_name:{
			type: DataTypes.STRING,
			validate: {
				notEmpty: true,
				len: [4,20]
			}
		},
		password_digest: DataTypes.STRING
	} ,
	{
		classMethods: 
			associate: (models) ->
				User.hasMany(models.Comment)
		
	})
	return User
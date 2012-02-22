class Indexit.Models.Entry extends Backbone.Model
  #not working
  validate: (attrs) ->
    if (_.isEmpty(attrs.uri))
      return 'cant be blank'
    else
      return 'vaya mierda'

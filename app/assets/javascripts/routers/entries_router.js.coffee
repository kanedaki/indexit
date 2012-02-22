class Indexit.Routers.Entries extends Backbone.Router
  routes:
    '': 'index'
    'entries/:id': 'show'

  initialize: ->
    @collection = new Indexit.Collections.Entries()
    @collection.reset($('#container').data('entries'))

  index: ->
    view = new Indexit.Views.EntriesIndex(collection: @collection)
    $('#container').html(view.render().el)

  show: (id) ->
    view = new Indexit.Views.Entry(model: @collection.get(id))
    $('#container').html(view.render().el)

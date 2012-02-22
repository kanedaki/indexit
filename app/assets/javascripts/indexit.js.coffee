window.Indexit =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: -> 
    new Indexit.Routers.Entries()
    Backbone.history.start(pushState: true)

$(document).ready ->
  Indexit.init()

class Indexit.Views.Entry extends Backbone.View
  template: JST['entries/entry']
  tagName: 'li'
  
  events:
    'click .detail': 'showEntry'

  render: ->
    $(@el).html(@template(entry: @model))
    this

  showEntry: ->
    Backbone.history.navigate("entries/#{@model.get('id')}", true)

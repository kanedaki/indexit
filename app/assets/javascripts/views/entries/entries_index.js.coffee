class Indexit.Views.EntriesIndex extends Backbone.View

  template: JST['entries/index']

  events:
    'submit #new_entry': 'createEntry'
    'submit #searchForm': 'search'

  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @appendEntry, this)

  render: ->
    $(@el).html(@template())
    @collection.each(@appendEntry)
    this

  appendEntry: (entry) =>
    view = new Indexit.Views.Entry(model: entry)
    @$('#entries').append(view.render().el)

  createEntry: (event) ->
    event.preventDefault()
    attributes = uri: $('#new_entry_uri').val()
    @collection.create attributes,
      wait: true
      success: -> $('#new_entry')[0].reset()
      error:  @handleError

  search: (event) ->
    event.preventDefault()
    literal= $('#literal').val()
    @collection.fetch({data: {search_term: literal}},
      success: -> $('#searchForm')[0].reset(),
      error: @handleError)

  handleError: (entry, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages

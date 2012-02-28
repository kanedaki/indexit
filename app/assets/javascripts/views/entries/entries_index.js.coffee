class Indexit.Views.EntriesIndex extends Backbone.View

  template: JST['entries/index']

  events:
    'submit #new_entry': 'createEntry'
    'submit #searchForm': 'search'

  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @appendEntry, this)
    @bookmarklet()
    

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

  bookmarklet: ->
    style = "style-newspaper"
    size = "size-medium"
    margin = "margin-wide"

    baseHref = window.location.toString().match(/.*\//)
    if (baseHref[0].match(/es\//i))
        baseHref = baseHref[0].replace(/es\//i, '')
    linkStringStart = "javascript:(function(){"
    linkStringEnd   = "';_readability_script=document.createElement('SCRIPT');_readability_script.type='text/javascript';_readability_script.src='" + baseHref + "js/readability.js?x='+(Math.random());document.getElementsByTagName('head')[0].appendChild(_readability_script);_readability_css=document.createElement('LINK');_readability_css.rel='stylesheet';_readability_css.href='" + baseHref + "css/readability.css';_readability_css.type='text/css';_readability_css.media='all';document.getElementsByTagName('head')[0].appendChild(_readability_css);_readability_print_css=document.createElement('LINK');_readability_print_css.rel='stylesheet';_readability_print_css.href='" + baseHref + "css/readability-print.css';_readability_print_css.media='print';_readability_print_css.type='text/css';document.getElementsByTagName('head')[0].appendChild(_readability_print_css);})();";"'})"

    $("#bookmarkletLink").attr("href", linkStringStart + "readStyle='" + style + "';readSize='" + size + "';readMargin='" + margin + linkStringEnd)

class window.TheaterView extends Backbone.View
  
  initialize: (options = {}) ->
    @width = options.width || 450
  
  events:
    "click .theater-curtain": "close"
    
  close: ->
    @remove()
    
  play: (view) ->
    # structure
    $('body').append @render().el
    # width
    @.$('.theater-container').css 'width', @width
    @.$('.theater-container').css 'left', ($(window).width() - @width) / 2
    # movie
    @.$('.theater-movie').html view
    # delegate
    view.theater = @
    
  render: ->
    $(@el).html Mustache.to_html($('#theater-template').html())
    
    @
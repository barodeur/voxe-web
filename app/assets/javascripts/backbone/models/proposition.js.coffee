class window.PropositionModel extends Backbone.Model
  
  # http://voxe.org/platform/models/proposition
  
  initialize: ->
    # comments
    @comments = new CommentsCollection(proposition: @)
    @comments.bind 'remove', @updateCommentsCount, @
    
    # embeds
    @embeds = new EmbedsCollection(@get 'embeds')
    @bind "change:embeds", (proposition) =>
      @embeds.reset proposition.get "embeds"
    
  commentsCount: ->
    @get("comments").count

  updateCommentsCount: ->
    @get("comments").count = @comments.length
    @trigger 'change:commentsCount'
  
  candidacy: ->
    @get "candidacy"
  
  candidacies: ->
    @get "candidacies"
  
  tags: ->
    @get "tags"
    
  id: ->
    @get "id"
    
  text: ->
    @get "text"

  url: ->
    "/api/v1/propositions/#{@id}"

  parse: (response) ->
    response.response?.proposition || super

  addEmbed: (url, title) ->
    model = @
    $.ajax
      type: 'POST'
      url: "#{@url()}/addembed"
      data: {url: url, title: title}
      success: (response) ->
        model.set embeds: response.response.proposition.embeds

  removeEmbed: (embedId) ->
    model = @
    $.ajax
      type: 'DELETE'
      url: "#{@url()}/removeembed"
      data: {embedId: embedId}
      complete: (response) ->
        if response.status == 200
          # sync collection with server
          embeds = model.get 'embeds'
          model.set embeds: _.reject(embeds, (e) -> e.id == embedId)

  favorite: ->
    $.ajax
      type: 'POST'
      url: "#{@url()}/favorite"
      data:
        auth_token: app.models.user.token()

  isFavorite: ->
    console.log @ if @get('favorite_users').count > 0
    console.log(@get('favorite_users').data[0].id) if @get('favorite_users').count > 0
    _.find @get('favorite_users').data, (u) -> u.id == app.models.user.id

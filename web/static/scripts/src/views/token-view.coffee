$ = require 'jquery'
_ = require 'lodash'
Backbone = require 'backbone'
Backbone.$ = $


module.exports = class TokenView extends Backbone.View

    className: 'pos__token'

    tagName: 'li'

    template: require 'templates/token-template'

    initialize: ->
        @listenTo Backbone, 'legend:hover:on', @hoverOn
        @listenTo Backbone, 'legend:hover:off', @hoverOff

    events: {
    }

    hoverOn: (pos) =>
        console.log pos, @model.get('pos')
        if pos isnt @model.get('pos') then @$el.addClass 'pos__token--dim' else @$el.addClass 'pos__token--focus'

    hoverOff: =>
        @$el.removeClass 'pos__token--dim pos__token--focus'

    posClass: ->
        pos = @model.get('pos').toLowerCase()
        @$el.addClass "pos__token--#{pos}"

    render: ->
        html = @template @model.toJSON()
        @$el.html html
        @posClass()

        return this

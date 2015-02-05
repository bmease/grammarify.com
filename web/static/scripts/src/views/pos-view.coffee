$ = require 'jquery'
_ = require 'lodash'
Backbone = require 'backbone'
Backbone.$ = $

TokenView = require 'views/token-view'


exampleSentences = [
    "I stepped on a Corn Flake, now I'm a Cereal Killer."
    "What do you think about the magical yellow unicorn who dances on the rainbow with a spoonful of blue cheese dressing?"
    "A man named Marvrick, is a man who loves cows."
    "Screw world peace, I want a pony!"
    "Smile, it makes people wonder what you are thinking."
    "Always remember you’re unique, just like everyone else."
    "He who laughs last thinks slowest!"
    "Half of the people in the world are below average."
    "Advice is what we ask for when we already know the answer but wish we didn't."
    "Middle age is when your age starts to show around your middle."
    "When it comes to thought, some people stop at nothing."
    "Why do psychics have to ask you for your name?"
    "I get enough exercise pushing my luck."
    "The more people I meet, the more I like my dog."
    "Beauty is in the eye of the beer holder."
    "Those who throw dirt only lose ground."
    "Experience is what you get when you didn’t get what you wanted."
    "This sentence is a lie."
    "Change is good, but dollars are better."
]


module.exports = class PosView extends Backbone.View

    className: 'pos'

    template: require 'templates/pos-template'

    initialize: ->
        @random()

        @listenTo @collection, 'reset', @render

    events: {
        'click .pos__btn': 'show'
        'keypress .pos__input': 'showOnEnter'
        'mouseenter .pos__legend-item': 'hoverLegendOn'
        'mouseleave .pos__legend-item': 'hoverLegendOff'
    }

    random: ->
        @collection.query _.sample exampleSentences

    show: (e) =>
        e.preventDefault()
        @collection.query $('.pos__input').val()

    showOnEnter: (e) =>
        if e.keyCode is 13 then @collection.query $('.pos__input').val()

    hoverLegendOn: (e) =>
        pos = $(e.target).data('pos')
        Backbone.trigger('legend:hover:on', pos)

    hoverLegendOff: =>
        Backbone.trigger('legend:hover:off')

    renderSentence: ->
        html = (new TokenView({model: model}).render().el for model in @collection.models)
        @$el.find('.pos__list').html html

    render: ->
        html = @template {}
        @$el.html html

        @renderSentence()
        return this

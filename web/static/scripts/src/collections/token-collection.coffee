$ = require 'jquery'
_ = require 'lodash'
nlp = require 'nlp_compromise'
Backbone = require 'backbone'
Backbone.$ = $

Token = require 'models/token'


module.exports = class TokenCollection extends Backbone.Collection
    model: Token

    query: (q) ->
        console.log nlp.pos q

        tokens = []
        for t in nlp.pos(q, {dont_combine: true}).sentences[0].tokens
            tokens.push new Token {pos: t.pos.parent, token: t.text}
        # @fetch { url: '/api/pos/', reset: true, data: {q: q}}
        @reset tokens

$ = require 'jquery'
_ = require 'lodash'
Backbone = require 'backbone'
Backbone.$ = $

Token = require 'models/token'


module.exports = class TokenCollection extends Backbone.Collection
    model: Token

    query: (q) ->
        @fetch { url: '/api/pos/', reset: true, data: {q: q}}

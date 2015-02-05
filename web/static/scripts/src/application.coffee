jQuery = require 'jquery'
PosView = require 'views/pos-view'
TokenCollection = require 'collections/token-collection'

# helpers = require 'templates/helpers'
# helpers.register()


jQuery ->
    tokenCollection = new TokenCollection
    posView = new PosView {collection: tokenCollection}
    jQuery('body').html posView.render().el

    global.window.posView = posView


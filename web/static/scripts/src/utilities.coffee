Token = require 'models/token'


PUNCTUATION_REGEX = /[^\w\s]/g


module.exports = {

    hasPunctuation: (token, last=false) ->
        character = if last then token.slice(-1) else token.charAt(0)
        punctuation = character.match(PUNCTUATION_REGEX)
        if punctuation
            return new Token {
                pos: 'glue'
                token: punctuation[0]
                name: 'punctuation'
                example: ', . ? "'
                reason: 'regex'
            }
        else
            return null


    stripPunctuation: (text) ->
        r = new RegExp("^#{PUNCTUATION_REGEX.source}|#{PUNCTUATION_REGEX.source}$", '')
        return text.replace r, ''
}

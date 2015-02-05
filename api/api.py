from flask import request
from flask.ext.api import FlaskAPI

import spacy.en
nlp = spacy.en.English()


app = FlaskAPI(__name__)

POS_TO_STRING = {
    spacy.parts_of_speech.NO_TAG: 'NO_TAG',
    spacy.parts_of_speech.ADJ: 'ADJ',
    spacy.parts_of_speech.ADV: 'ADV',
    spacy.parts_of_speech.ADP: 'ADP',
    spacy.parts_of_speech.CONJ: 'CONJ',
    spacy.parts_of_speech.DET: 'DET',
    spacy.parts_of_speech.NOUN: 'NOUN',
    spacy.parts_of_speech.NUM: 'NUM',
    spacy.parts_of_speech.PRON: 'PRON',
    spacy.parts_of_speech.PRT: 'PRT',
    spacy.parts_of_speech.VERB: 'VERB',
    spacy.parts_of_speech.X: 'X',
    spacy.parts_of_speech.PUNCT: 'PUNCT',
    spacy.parts_of_speech.EOL: 'EOL',
}

def token_to_object(token):
    return {
        'token': token.string.strip(),
        'pos': POS_TO_STRING[token.pos]
    }


@app.route('/api/pos/')
def parts_of_speech():
    query = request.args.get('q', '')
    tokens = nlp(query)
    return [token_to_object(t) for t in tokens]



if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)

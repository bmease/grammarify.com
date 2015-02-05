FROM dockerfile/python

RUN mkdir /app
WORKDIR /app
ADD . /app/

RUN pip install -r requirements.txt
RUN python -m spacy.en.download

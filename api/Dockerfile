FROM dockerfile/python

RUN mkdir /app
WORKDIR /app
ADD requirements.txt /app/

RUN pip install -r requirements.txt
RUN python -m spacy.en.download

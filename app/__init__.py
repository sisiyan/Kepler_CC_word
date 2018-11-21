"""
Package: app
Package for the application models and services.
"""
# import logging
# import os
# import sys
from flask import Flask, Response, jsonify, request, json, url_for, make_response,abort
from flask_api import status
# from werkzeug.exceptions import BadRequest, NotFound, UnsupportedMediaType, InternalServerError # Exception Class

from app.models import RandomWord, RhymeWords, StemWords

# Create Flask application
app = Flask(__name__)

"""
Display the home page
"""
@app.route('/',methods=['GET'])
def home():
    return jsonify(name='Welcome to Words RESTFUL API',\
                   version='1.0'), status.HTTP_200_OK

@app.route('/words',methods=['GET'])
def index():
    return jsonify(name="Let's enter Words Games!"), status.HTTP_200_OK

"""
Pick a Random Word from input
"""
@app.route('/words/randomword', methods=['GET'])
def random_word():
    if 'input' in request.args: #Convert the input string into a list of words
        words = request.args['input'].split(",")
    else:      # Abort the request and throw error messgae
        abort(400,'Input not provided!')

    # Abort the request and throw error message if the number of words is less 2
    # greater than 50
    if words is None or len(words) < 2:
        abort(400,'At least 2 words need to be input!')

    if len(words) > 50:
        abort(400,'Too many words! Please input 50 words or less.')

    # Abort the request if length of any word is greater than 45.
    # The longest word Pneumonoultramicroscopicsilicovolcanoconiosis in main dictionaries has 45 letters
    for w in words:
        if len(w) > 45:
            abort(400,'Too long word! Please check the input!')

    #Call the method from the RandomWord class to get the random word
    word = RandomWord.generate_random_word(words)
    return make_response(jsonify({"randomly picked word": word}), status.HTTP_200_OK)

"""
Generate a list of English words that rhyme with the input word
"""
@app.route('/words/rhyme/<string:word>', methods=['GET'])
def rhyming_words(word='Happy'):
    """
    It will skip the words after the first comma if a comma separated
    list is provided.
    The API call "/words/rhyming/{word}" is routed to this
    method where {word} is any english word.

    NOTE - Before calling the function from Rhyme class in models module,
    following checks are performed -
    1. If the word is not a proper English word (contains any non-alphabet
     character), abort the request.
    2. If length of the word is greater than 45, abort the
    request because longest word in Oxford dictionary is of length 45.
    """
    #Check number of input word
    input = word.split(",")
    if len(input) > 1:
        abort(400,'Too many words are input. Please input only one word!')
    input = word.split(" ")
    if len(input) > 1:
        abort(400,'Too many words are input. Please input only one word!')

    word = input[0]

    #Abort if the the word is not a valid English word
    if not word.isalpha():
        abort(400,'The word is not a valid english word.')

    # Abort the request if length of the word is greater than 45
    if len(word) > 45:
        abort(400,'Too long word! Check the word correctness.')

    #Get the list of rhyming words
    rhyming_words = RhymeWords.find_rhyming_words(word)
    return make_response(jsonify(rhyming_words), status.HTTP_200_OK)


"""
  Generate root words for the input words
"""
@app.route('/words/stem', methods=['GET'])
def stem_words():
    #Split the input list into words
    if 'input' in request.args:
        words = request.args['input'].split(",")
    else:      # Abort the request with error messgae  if the 'input' is not provided
        abort(400,'Input not provided!')

    # Abort the request with error message if the number of words is greater than 50
    if words is None or len(words) > 50:
        abort(400,'No more than 50 words can be processed.')

    # Abort the request if length of any word is greater than 45.
    #Longest word in Oxford dictionary is of length 45.
    for w in words:
        if len(w) > 45:
            abort(400,'Too long word! Please check!')

    #Call the method from the Stemmer class to get the random word
    root_words = StemWords.get_roots(words)
    return make_response(jsonify(root_words), status.HTTP_200_OK)

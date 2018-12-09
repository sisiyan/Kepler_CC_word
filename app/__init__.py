"""
Package: app
Package for the application models and services.
"""

from flask import Flask, Response, jsonify, request, json, url_for, make_response,abort
from flask_api import status

from app.models import RandomWord, RhymeWords, StemWords

# Create Flask application
app = Flask(__name__)

"""
Display the home page
"""
@app.route('/',methods=['GET'])
def home():
    return jsonify(info='Welcome to Words RESTFUL API!',\
                   name='Homepage of Words RESTFUL API',\
                   version='1.0'), status.HTTP_200_OK

"""
Display the Words main page
"""
@app.route('/words',methods=['GET'])
def index():
    return jsonify(info="Let's enter Words Games!"), status.HTTP_200_OK

"""
Pick a Random Word from input
"""
@app.route('/words/randomword', methods=['GET'])
def random_word():
    if 'input' in request.args: #Convert the input string into a list of words
        words = request.args['input'].split(",")
    else:  #If no input, abort the request and throw error messgae
        abort(400,'Input not provided!')

    # Abort the request and throw error message if the number of input words is less 2

    if words is None or len(words) < 2:
        abort(400,'At least 2 words need to be input!')

    # Abort the request and throw error message if the number of input words is greater than 50
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
@app.route('/words/rhyme', methods=['GET'])
def rhyming_words():
    if 'input' in request.args: #Convert the input string into a list of words
        words = request.args['input'].split(",")
    else:  # If not input word, abort the request and throw error messgae
        abort(400,'Input not provided!')

    # Abort the request and throw error message if more than one word is input
    if len(words) > 1:
        abort(400,'Too many words! Please input one word.')


    word = words[0]

    # If no word pass to the input, abort and throw error message.
    if word == '':
        abort(400,'No word is provided!')

    #Abort if the the word is not a valid English word
    if not word.isalpha():
        abort(400,'The word is not a valid English word.')

    # Abort the request if length of the word is greater than 45
    if len(word) > 45:
        abort(400,'Too long word! Check the word correctness.')

    #Get the list of rhyming words
    rhyming_words = RhymeWords.find_rhyming_words(words[0])
    return make_response(jsonify(rhyming_words), status.HTTP_200_OK)

"""
  Generate root words for the input words
"""
@app.route('/words/stem', methods=['GET'])
def stem_words():
    #Split the input list into words
    if 'input' in request.args:
        words = request.args['input'].split(",")
    else:  # Abort the request with error messgae, if the 'input' is not provided
        abort(400,'Input not provided!')

    # Abort the request with error message if the number of words is greater than 50
    if len(words) > 50:
        abort(400,'Too many words. No more than 50 words can be processed.')

    # If no word pass to the input, abort and throw error message.
    if len(words) == 1 and words[0]=='':
        abort(400,'No word was input.')

    # Abort the request if length of any word is greater than 45.
    #Longest word in Oxford dictionary is of length 45.
    for w in words:
        if len(w) > 45:
            abort(400,'Too long word! Please check!')

        if not w.isalpha():
            abort(400,'The word '+ w + ' is not a valid English word.')

    #Call the method from the Stemmer class to get the stemmed words
    root_words = StemWords.get_roots(words)
    return make_response(jsonify(root_words), status.HTTP_200_OK)

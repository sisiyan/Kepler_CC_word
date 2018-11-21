"""
The data models for the Word Restful API

"""

import os
import json
import random
import pronouncing
from nltk.stem.snowball import SnowballStemmer

class RandomWord:
    """The class for the random word selection.
    """
    @staticmethod
    def generate_random_word(words):
        """
        Randomly select a word from the given word list (words).
        @parameter - words: a list of words from input
        return: a word randomly selected from the words list
        """
        numOfWords = len(words) #Get the number of words in the list

        index = random.randint(0, numOfWords-1) #Generate random index value

        return words[index]

class RhymeWords:
    """
        The class for the list of words rhyming with input word.
    """
    @staticmethod
    def find_rhyming_words(word):
        """ Get a list of words rhyming with the input word

        @parameter - word: an English word
        return: a list of words rhyming with the input word

        NOTE: The "pronouncing" package is used to
        provide rhyming words from the CMU Pronouncing Dictionary.
        """

        rhyming_words = pronouncing.rhymes(word)
        return rhyming_words

class StemWords:
    """
        The class for searching the root words of a list of words.
    """
    @staticmethod
    def get_roots(words):
        """ Get the root words for each word in a list.

        @parameter - words: a list of words from input
        return: a list of words that are roots for each word in the given list

        NOTE: The nltk.stem package is used to get the root.
        """

        stem_words = []

        stemmer = SnowballStemmer("english") #Use the SnowballStemmer for stemming
        for w in words:
            #Stem each word in the input list and add to result list
            stem_words.append(stemmer.stem(w))

        return stem_words

# Restful API for Kepler Group Code Excercise

This repository includes the documents and code for implementing a restful API for interesting word operations (Option 2).

## Project requirements
### Functional requirements:
The API should enable users to perform the following actions:
 1) User provides 2 or more words to the server, and the server randomly returns 1 word
 2) User provides 1 English word, and server returns a list of English words that rhyme with that word
 3) Add an endpoint that does something cool. This API will encrypt a word with RSA

### Other requirements:
 1) The application should be able to run on Ubuntu 18.04.
 2) Automated testing.

## The directory structure.
 ```bash
 ├── app
 │   ├──__init__.py
 │   ├── models.py
 │    
 ├── tests
 |   ├── README.md
 │   ├── tests.sh
 │  
 ├── README.md
 ├── requirments.txt
 ├── run.py
 │
 └── .gitignore
 ```

## Environment set-up
Set up the virtual environment using Virtualenv.
1) Make sure python 3.5 or 3.6 was installed on your linux machine.
2) On your machine, open a terminal and type

       $ pip install virtualenv

   Message "Successfully installed virtualenv-16.1.0" will be displayed in the terminal after installation.
3) Create a directory for this app, and create a virtual environment for the app. Type in command line

       $ mkdir syan_codingExcercise

       $ cd syan_codingExcercise

       $ virtualenv --python=/usr/bin/pythonX.Y flaskAPI_env

    (Use your python version to replace X and Y.)
    The terminal should display
    "Installing setuptools, pip, wheel...
    done."

4) Clone this repo on your computer or cluster. Then, go to the git directory.

       $ git clone https://github.com/sisiyan/Kepler_CC_word.git

       $ cd Kepler_CC_word

5) Activate the environment flaskAPI_envType, by typing in command line

       $ source ../flaskAPI_env/bin/activate

    Next line will start with "(flaskAPI_env) ". This means that we entered the virtual environment.

6) Install the dependencies that are specified in the requirements.txt file:

       $ pip install -r requirements.txt

## Running the application
1) In the Kepler_CC_word directory, type

       $ python3 run.py

2) Input http://localhost:5000 or http://0.0.0.0:5000/ in your browser. On the webpage, you should see:

        {info:	"Welcome to Words RESTFUL API!"
         name:	"Homepage of Words RESTFUL API"
         version:	"1.0"}

3) Manually try each function on the browser.
* The randomly picking word function:
  Type http://0.0.0.0:5000/words/randomword?input=April,May,June,July in the browser.
  Refresh multiple times, and you will see different word picked from time to time.

* Finding the rhyming words function:
  Type http://0.0.0.0:5000/words/rhyme?input=text in your browser.
  You will see a list of words rhyming with "text":

      { 0:	"annexed"
        1:	"flexed"
        2:	"hext"
        3:	"kekst"
        4:	"next"
        5:	"perplexed"
        6:	"sexed"
        7:	"teletext"
        8:	"vexed"}

* The word stemming function:
  Type http://0.0.0.0:5000/words/stem?input=test,tested,tests in your browser.
  You will see the stemmed word for each input word:

      { 0:	"test"
        1:	"test"
        2:	"test"}

## The automated tests on more test cases.
1) If the API service is not currently running, go to the Kepler_CC_word directory, start the service.

       $ python3 run.py

2) Open another terminal. Go to the tests directory, and run the test.sh script.

       $ cd tests
       $ ./test.sh

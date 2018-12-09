import os
from app import app

#Pull options from environment, if provided, otherwise default will be chosen
#DEBUG = (os.getenv('DEBUG', 'False') == 'True')
PORT = os.getenv('PORT', '5000')

######################################################################
#   M A I N
######################################################################
if __name__ == "__main__":

    #Run the application
    app.run(host='0.0.0.0', port=int(PORT))

# from flask import Flask, jsonify
# from app import app

#app = create_app()

# tasks = [
#     {
#         'id': 1,
#         'title': u'Buy groceries',
#         'description': u'Milk, Cheese, Pizza, Fruit, Tylenol',
#         'done': False
#     },
#     {
#         'id': 2,
#         'title': u'Learn Python',
#         'description': u'Need to find a good Python tutorial on the web',
#         'done': False
#     }
# ]
#
# @app.route('/', methods=['GET'])
# def index():
#     return 'Hello, Flask!'

# def get_tasks():
#     return jsonify({'tasks': tasks})


import os
from app import app

#Pull options from environment, if provided, otherwise default will be chosen
#DEBUG = (os.getenv('DEBUG', 'False') == 'True')
PORT = os.getenv('PORT', '5000')

######################################################################
#   M A I N
######################################################################
if __name__ == "__main__":

    #Initialize logging
    #service.initialize_logging()

    #Run the application
    app.run(host='0.0.0.0', port=int(PORT))

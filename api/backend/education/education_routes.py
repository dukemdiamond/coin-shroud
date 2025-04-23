from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db

education = Blueprint('education', __name__)

@education.route('/', methods=['GET'])
def get_education():
    cursor = db.get_db().cursor()

    cursor.execute('SELECT educationID, information FROM Education')
    data = cursor.fetchall()
    response = make_response(jsonify(data))
    response.status_code = 200

    return response




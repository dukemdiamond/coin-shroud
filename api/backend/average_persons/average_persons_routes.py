from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db

average_persons = Blueprint('average_persons', __name__)

@average_persons.route('/', methods=['GET'])
def get_users():
    current_app.logger.info('GET /average_persons route')
    cursor = db.get_db().cursor()
    cursor.execute('''SELECT userID, FName, LName, email FROM Average_Persons''')

    userData = cursor.fetchall()

    user_response = make_response(jsonify(userData))
    user_response.status_code = 200
    return user_response

@average_persons.route('/<userID>', methods=['GET'])
def get_user(userID):
    current_app.logger.info('GET /average_persons/<userID> route')

    cursor = db.get_db().cursor()
    cursor.execute('SELECT userID, FName, LName, email FROM Average_Persons WHERE userID = %s', (userID))

    userData = cursor.fetchall()

    if not userData:
        return jsonify({'Error': 'User not found'}), 404

    userData = make_response(jsonify(userData))
    userData.status_code = 200
    return userData


@average_persons.route('/<userID>', methods = ['PUT'])
def update_user():
    current_app.logger.info('PUT /average_persons/<userID> route')
    user_info = request.json
    usrID = user_info['userID']
    first = user_info['FName']
    last = user_info['LName']
    email = user_info['email']


    query = 'UPDATE Average_Persons SET FName = %s, LName = %s, email = %s WHERE userID = %s'
    data = (first,last,email,usrID)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return 'user updated!'

@average_persons.route('/<userID>/portfolio', methods=['GET'])
def get_user_portfolio(userID):
    current_app.logger.info('GET /average_persons/<userID>/portfolio route')

    cursor = db.get_db().cursor()
    # Get portfolio information
    cursor.execute('''SELECT portfolioID, value, holdings, userID FROM Portfolio WHERE userID = %s''', userID)

    data = cursor.fetchall()

    r = make_response(jsonify(data))
    r.status_code = 200

    return r

@average_persons.route('/<userID>', methods=['DELETE'])
def delete_user(userID):
    current_app.logger.info('Delete /average_persons/<userID> route')

    try:
        cursor = db.get_db.cursor()
        cursor.execute('SELECT userID FROM Average_Persons WHERE userID = %s', (userID))

        if not cursor.fetchall():
            return jsonify({'Error': 'could not find user.'}), 404

        cursor.execute('DELETE FROM Average_Persons WHERE userID = %s' (userID))

        db.get_db().commit()
        return jsonify({'message': f'User {userID} succesfully deleted'}), 200

    except Exception as e:

        db.get_db().rollback()
        current_app.logger.error(f'Error deleting user: {str(e)}')
        return jsonify({'error': 'Failed to delete user'}), 500
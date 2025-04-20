from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db

withdrawals = Blueprint('withdrawals', __name__)

@withdrawals.route('/withdrawals', methods=['GET'])
def get_withdrawals():
    current_app.logger.info('GET /withdrawals route')

    cursor = db.get_db().cursor()

    cursor.execute('SELECT withdrawalID, amount, status, date, investorID, userID FROM Withdrawals')

    data = cursor.fetchall()
    r = make_response(jsonify(data))
    r.status_code = 200

    return r


@withdrawals.route('/withdrawals/<withdrawalID>', methods=['GET'])
def get_withdrawal(withdrawalID):
    current_app.logger.info('GET /withdrawals/<withdrawalID> route')

    cursor = db.get_db().cursor()

    cursor.execute('SELECT withdrawalID, amount, status, date, investorID, userID FROM Withdrawals WHERE withdrawalID = %s', withdrawalID)
    data = cursor.fetchall()
    r = make_response(jsonify(data))
    r.status_code = 200

    return r

@withdrawals.route('/withdrawals', methods=['POST'])
def create_withdrawal():
    current_app.logger.info('POST /withdrawals route')

    data = request.json

    if ('userID' not in data and 'investorID' not in data):
        return jsonify({'error': 'Either a user ID or investor ID must be present.'})

    amount = data['amount']
    status = data['status']
    date = data['date']
    investor_id = data.get('investorID', None)
    user_id = data.get('userID', None)

    try:
        cursor = db.get_db().cursor()
        cursor.execute('''INSERT INTO Withdrawals (amount, status, date, investorID, userID)
                       VALUES(%s, %s, %s, %s, %s)''', (amount, status, date, investor_id, user_id))

        db.get_db.commit()

        return jsonify('Withdrawal successful')

    except Exception as e:
        db.get_db.rollback()
        return jsonify({'Error': 'Withdrawal not created.'})




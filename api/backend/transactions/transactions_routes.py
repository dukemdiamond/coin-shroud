from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db

transactions = Blueprint('transactions', __name__)

@transactions.route('/transactions', methods=['GET'])
def get_transactions():

    current_app.logger.info('GET /transactions route')

    cursor = db.get_db().cursor()
    cursor.execute('''SELECT transactionID, userID, investorID, projectID, buy, sell FROM Transactions''')

    transactionData = cursor.fetchall()

    response = make_response(jsonify(transactionData))
    response.status_code = 200
    return response

@transactions.route('/transactions', methods=['POST'])
def create_transaction():
    # Log
    current_app.logger.info('POST /transactions route')

    # Gets request data
    data = request.json

    if ('userID' not in data and 'investorID' not in data):
        return jsonify({'Error: Either a user ID or investor ID must be present.'})

    if ('buy' in data and data['buy'] and 'sell' in data and data['sell'] or
            ('buy' not in data and 'sell' not in data)):
        return jsonify({'Error: Either must be ONLY a buy operation or ONLY a sell operation.'})

    if ('projectID' not in data):
        return jsonify({'Must specify what project you are making a transaction on.'})

    # Default vals (can be null):
    buy_value = 1 if 'buy' in data and data['buy'] else 0
    sell_value = 1 if 'sell' in data and data['sell'] else 0
    user_id = data.get('user_ID', None)
    investor_id = data.get('investor_ID', None)

    try:
        cursor = db.get_db().cursor()
        cursor.execute('''
        INSERT INTO Transactions (buy, sell, userID, investorID, projectID)
        VALUES (?, ?, ?, ?, ?) ''', (buy_value, sell_value, user_id, investor_id, data['projectID']))

        db.get_db.commit()

        transactionID = cursor.lastrowid

        return jsonify({
            'transactionID': transactionID,
            'message': 'Transaction created successfully'
        })

    except Exception as e:
        # Error Wont be committed to the DB
        db.get_db.rollback()
        return jsonify({"Error: transaction not created."})


@transactions.route('/transactions/{transactionID}', methods=['GET'])
def get_transaction(transaction_id):
    # Log
    current_app.logger.info('GET /transactions/{id} route')
    try:
        cursor = db.get_db().cursor()
        cursor.execute('SELECT buy, sell, userID, investorID, projectID FROM Transactions WHERE transactionID = %s' (transaction_id))

        data = cursor.fetchall()

        if not data:
            return jsonify({'Error': 'Transaction not found'}), 404

        # Organized transaction for return
        transaction = {
            'transactionID': transaction_id,
            'buy': bool(data[0]),
            'sell': bool(data[1]),
            'userID': data[2],
            'investorID': data[3],
            'projectID': data[4]
        }
        response = make_response(jsonify(transaction))
        response.status_code = 200
        return response

    except Exception as e:
        current_app.logger.error(f'Error retrieving transaction: {str(e)}')
        return jsonify({'error': 'Failed to retrieve transaction data'}), 500




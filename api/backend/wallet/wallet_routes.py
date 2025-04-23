from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db

wallet = Blueprint('wallet', __name__)

# since wallet is specific to client side, do not need to query by specific investorID etc

@wallet.route('/', methods=['GET'])
def get_wallet():
    current_app.logger.info('GET /wallet route')

    cursor = db.get_db().cursor()
    cursor.execute('''SELECT walletID, balance, investorID, userID FROM Wallet''')
    data = cursor.fetchall()
    response = make_response(jsonify(data))
    response.status_code = 200

    return response

@wallet.route('/', methods=['POST'])
def create_wallet():
    try:
        data = request.json

        # if there's no walletID, make one
        if 'walletID' not in data:
            import uuid
            data['walletID'] = str(uuid.uuid4())

        # Check that either userID or investorID is provided (but not both)
        if 'userID' not in data and 'investorID' not in data:
            return jsonify({'error': 'Either userID or investorID must be provided'}), 400

        if 'userID' in data and 'investorID' in data and data['userID'] and data['investorID']:
            return jsonify({'error': 'Wallet can only be associated with either a user or an investor, not both'}), 400

        balance = data.get('balance', 0)

        cursor = db.get_db().cursor()
        # Check if user/investor exists
        if 'userID' in data and data['userID']:
            cursor.execute('SELECT userID FROM Average_Persons WHERE userID = %s', (data['userID'],))
            if not cursor.fetchone():
                return jsonify({'error': 'User not found'}), 404

            # Check if user already has a wallet
            cursor.execute('SELECT walletID FROM Wallet WHERE userID = %s', (data['userID'],))
            if cursor.fetchone():
                return jsonify({'error': 'User already has a wallet'}), 409

        if 'investorID' in data and data['investorID']:
            cursor.execute('SELECT investorID FROM Investors WHERE investorID = %s', (data['investorID'],))
            if not cursor.fetchone():
                return jsonify({'error': 'Investor not found'}), 404

            # Check if investor already has a wallet
            cursor.execute('SELECT walletID FROM Wallet WHERE investorID = %s', (data['investorID'],))
            if cursor.fetchone():
                return jsonify({'error': 'Investor already has a wallet'}), 409

        # Create wallet
        cursor.execute('''
                INSERT INTO Wallet (walletID, balance, investorID, userID)
                VALUES (%s, %s, %s, %s)
            ''', (
            data['walletID'],
            balance,
            data.get('investorID', None),
            data.get('userID', None)
        ))

        # Commit
        db.get_db().commit()

        return jsonify({
            'message': 'Wallet created successfully',
            'walletID': data['walletID'],
            'balance': balance,
            'userID': data.get('userID', None),
            'investorID': data.get('investorID', None)
        }), 201

    except Exception as e:
        db.get_db().rollback()
        current_app.logger.error(f'Error creating wallet: {str(e)}')
        return jsonify({'error': f'Failed to create wallet: {str(e)}'}), 500


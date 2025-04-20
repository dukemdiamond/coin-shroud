from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db

investors = Blueprint('investors', __name__)

@investors.route('/investors', methods=['GET'])
def get_investors():
    current_app.logger.info('GET /investors route')
    cursor = db.get_db().cursor()
    cursor.execute('''SELECT investorID, FName, LName, email, agency FROM Investors''')

    investorData = cursor.fetchall()

    investor_response = make_response(jsonify(investorData))
    investor_response.status_code = 200
    return investor_response

@investors.route('/investors/<investorID>', methods=['GET'])
def get_investor(investorID):
    current_app.logger.info('GET /investors/<investorID> route')

    cursor = db.get_db().cursor()
    cursor.execute('SELECT investorID, FName, LName, email, agency FROM Investors WHERE investorID = %s', (investorID))

    investorData = cursor.fetchall()

    if not investorData:
        return jsonify({'Error': 'Investor not found'}), 404

    investor_response = make_response(jsonify(investorData))
    investor_response.status_code = 200
    return investor_response


@investors.route('/investors/<investorID>', methods = ['PUT'])
def update_investor():
    current_app.logger.info('PUT /investors/<investorID> route')
    inv_info = request.json
    inv_id = inv_info['investorID']
    first = inv_info['FName']
    last = inv_info['LName']
    email = inv_info['email']
    agency = inv_info['agency']


    query = 'UPDATE Investors SET FName = %s, LName = %s, email = %s, agency = %s WHERE investorID = %s'
    data = (first,last,email,agency, inv_id)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return 'investor updated!'

# still needs work
@investors.route('/investors/<investorID>/portfolio', methods=['GET'])
def get_investor_portfolio(investorID):
    current_app.logger.info('GET /investors/<investorID>/portfolio route')

    cursor = db.get_db().cursor()
    # Get portfolio information
    cursor.execute('''SELECT portfolioID, value, holdings, investorID FROM Portfolio WHERE investorID = %s''', investorID)

    data = cursor.fetchall()

    r = make_response(jsonify(data))
    r.status_code = 200

    return r

@investors.route('/investors/<investorID>', methods=['DELETE'])
def delete_investor(investor_id):
    current_app.logger.info('Delete /investors/<investorID> route')

    try:
        cursor = db.get_db.cursor()
        cursor.execute('SELECT investorID FROM Investors WHERE investorID = %s', (investor_id,))

        if not cursor.fetchall():
            return jsonify({'Error': 'could not find investor.'}), 404

        cursor.execute('DELETE FROM Investors WHERE investorID = %s' (investor_id))

        db.get_db().commit()
        return jsonify({'message': f'Investor {investor_id} succesfully deleted'}), 200

    except Exception as e:

        db.get_db().rollback()
        current_app.logger.error(f'Error deleting investor: {str(e)}')
        return jsonify({'error': 'Failed to delete investor'}), 500







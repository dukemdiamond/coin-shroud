########################################################
# Sample customers blueprint of endpoints
# Remove this file if you are not using it in your project
########################################################

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
    cursor.execute('''SELECT investorID, FName, LName, email FROM Investors''')

    investorData = cursor.fetchall()

    investor_response = make_response(jsonify(investorData))
    investor_response.status_code = 200
    return investor_response

@investors.route('/investors/<investorID>', methods=['GET'])
def get_investor(investorID):
    current_app.logger.info('GET /investors/<investorID> route')

    cursor = db.get_db().cursor()
    cursor.execute('SELECT investorID, FName, LName, email FROM Investors WHERE investorID = %s', (investorID))

    investorData = cursor.fetchall()

    if not investorData:
        return jsonify({'Error': 'Investor not found'}), 404

    investor_response = make_response(jsonify(investorData))
    investor_response.status_code = 200
    return investor_response
# CREATE TABLE Investors(
#     investorID VARCHAR(36) PRIMARY KEY,
#     FName TEXT NOT NULL,
#     LName TEXT NOT NULL,
#     email VARCHAR(100) NOT NULL
# );


@investors.route('/investors/<investorID>', methods = ['PUT'])
def update_investor():
    current_app.logger.info('PUT /investors/<investorID> route')
    inv_info = request.json
    inv_id = inv_info['investorID']
    first = inv_info['FName']
    last = inv_info['LName']
    email = inv_info['email']


    query = 'UPDATE Investors SET FName = %s, LName = %s, email = %s WHERE investorID = %s'
    data = (first,last,email, inv_id)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return 'investor updated!'

# still needs work
@investors.route('/investors/<investorID>/portfolio', methods=['GET'])
def get_investor_portfolio():
    current_app.logger.info('GET /investors/<investorID>/portfolio route')

    cursor = db.get_db().cursor()
    cursor.execute('''SELECT ''')

@investors.route('/investors/<investorID>', methods=['DELETE'])
def delete_investor():
    current_app.logger.info('Delete /investors/<investorID>/portfolio')







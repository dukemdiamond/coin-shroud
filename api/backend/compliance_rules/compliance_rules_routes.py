from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db

compliance_rules = Blueprint('compliance_rules', __name__)

@compliance_rules.route('/', methods=['GET'])
def get_compliance_rules():
    current_app.logger.info('GET /compliance_rules route')
    cursor = db.get_db().cursor()

    cursor.execute('SELECT c_id, compliance_rules FROM compliance_rules')

    data = cursor.fetchall()

    response = make_response(jsonify(data))
    response.status_code = 200
    return response

@compliance_rules.route('/<c_id>', methods=['PUT'])
def update_compliance_rules(c_id):
    current_app.logger.info('PUT /compliance_rules route')

    cursor = db.get_db().cursor()
    info = request.json
    rules = info['compliance_rules']

    r = cursor.execute('UPDATE compliance_rules SET compliance_rules = %s WHERE c_id = %s', (rules, c_id))
    db.get_db().commit()
    return jsonify({"message": "Compliance rules updated successfully"}), 200







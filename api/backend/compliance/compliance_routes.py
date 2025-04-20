from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db

compliance = Blueprint('compliance', __name__)

@compliance.route('/compliance', methods=['GET'])
def get_compliance_reports():
    current_app.logger.info('GET /compliance route')

    cursor = db.get_db().cursor()
    cursor.execute('''SELECT reportID, isCompliant, reportDate, regulatorID, projectID 
    FROM Compliance_Report''')

    data = cursor.fetchall()

    response = make_response(jsonify(data))
    response.status_code = 200
    return response

@compliance.route('/compliance/<projectID>', methods=['GET'])
def get_compliance_report(projectID):
    current_app.logger.info('GET /compliance/{projectID} route')

    cursor = db.get_db().cursor()
    cursor.execute('''SELECT reportID, isCompliant, reportDate, regulatorID, projectID 
    FROM Compliance_Report WHERE projectID = %s''', projectID)

    data = cursor.fetchall()

    response = make_response(jsonify(data))
    response.status_code = 200
    return response

@compliance.route('/compliance/{projectID}', methods=['PUT'])
def update_compliance_report(projectID):
    current_app.logger.info('PUT /compliance/ route')

    compliance_info = request.json
    comp_reportID = compliance_info['reportID']
    comp_isCompliant = compliance_info['isCompliant']
    comp_reportDate = compliance_info['reportDate']
    comp_regulatorID = compliance_info['regulatorID']

    query = 'UPDATE Compliance_Report SET reportID = %s, isCompliant = %s, reportDate = %s, regulatorID = %s, projectID = %s WHERE projectID = %s'
    data = (comp_reportID, comp_isCompliant, comp_reportDate, comp_regulatorID, projectID, projectID)

    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return 'compliance report updated'











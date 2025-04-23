from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db

compliance = Blueprint('compliance', __name__)

@compliance.route('/', methods=['GET'])
def get_compliance_reports():
    current_app.logger.info('GET /compliance route')

    cursor = db.get_db().cursor()
    cursor.execute('''SELECT reportID, isCompliant, reportDate, regulatorID, projectID 
    FROM Compliance_Report''')

    data = cursor.fetchall()

    response = make_response(jsonify(data))
    response.status_code = 200
    return response

@compliance.route('/<projectID>', methods=['GET'])
def get_compliance_report(projectID):
    current_app.logger.info('GET /compliance/{projectID} route')

    cursor = db.get_db().cursor()
    cursor.execute('''SELECT reportID, isCompliant, reportDate, regulatorID, projectID 
    FROM Compliance_Report WHERE projectID = %s''', projectID)

    data = cursor.fetchall()

    response = make_response(jsonify(data))
    response.status_code = 200
    return response

@compliance.route('/<projectID>', methods=['PUT'])
def update_compliance_report(projectID):
    current_app.logger.info('PUT /compliance/ route')

    compliance_info = request.json
    comp_isCompliant = compliance_info['isCompliant']
    comp_reportDate = compliance_info['reportDate']
    comp_regulatorID = compliance_info['regulatorID']

    query = 'UPDATE Compliance_Report SET isCompliant = %s, reportDate = %s, regulatorID = %sWHERE projectID = %s'
    data = (comp_isCompliant, comp_reportDate, comp_regulatorID, projectID)
    try:
        cursor = db.get_db().cursor()
        r = cursor.execute(query, data)
        db.get_db().commit()
        return jsonify({'message': f'Compliance report for project {projectID} updated'}), 200
    except Exception as e:
        db.get_db().rollback()
        current_app.logger.error(f'Failed to update compliance report: {str(e)}')
        return jsonify({'error': f'Failed to update compliance report: {str(e)}'}), 500










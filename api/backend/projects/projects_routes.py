from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db

projects = Blueprint('projects', __name__)

@projects.route('/', methods=['GET'])
def get_projects():

    cursor = db.get_db().cursor()
    cursor.execute('''SELECT projectID, name, status, quantity, price FROM Projects''')
    data = cursor.fetchall()

    r = make_response(data)
    r.status_code = 200

    return r

@projects.route('/<projectID>', methods=['GET'])
def get_project(projectID):

    cursor = db.get_db().cursor()
    cursor.execute('SELECT projectID, name, status, quantity, price FROM Projects WHERE projectID = %s', projectID)
    data = cursor.fetchall()

    r = make_response(data)
    r.status_code = 200

    return r

@projects.route('', methods=['POST'])
def create_project():

    try:
        current_app.logger.info('POST /projects/ route')

        p_info = request.json
        name = p_info['name']
        status = p_info['status']
        price = p_info['price']
        quantity = p_info['quantity']

        cursor = db.get_db().cursor()
        cursor.execute('INSERT INTO Projects (name, status, price, quantity)'
                 'VALUES (%s, %s, %s, %s)', (name, status, price, quantity))

        db.get_db().commit()

        return 'Project created successfully!'

    except Exception as e:
        db.get_db().rollback()
        current_app.logger.error(f'Error creating project: {str(e)}')
        return jsonify({'error': f'Failed to create project: {str(e)}'}), 500







@projects.route('/<projectID>', methods=['PUT'])
def update_project(projectID):
    current_app.logger.info('PUT /projects/<projectID> route')

    p_info = request.json
    name = p_info['name']
    status = p_info['status']
    price = p_info['price']
    quantity = p_info['quantity']

    query = 'UPDATE Projects SET name = %s, status = %s, price = %s, quantity = %s WHERE projectID = %s'
    data = (name,status,price,quantity, projectID)

    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()

    return 'Project Updated!'

@projects.route('/<projectID>', methods=['DELETE'])
def delete_project(projectID):
    current_app.logger.info('DELETE /projects/<projectID> route')

    try:
        cursor = db.get_db.cursor()
        cursor.execute('SELECT projectID FROM Projects WHERE projectID = %s', projectID)

        if not cursor.fetchall():
            return jsonify({'Error': 'Could not find project'}), 404

        cursor.execute('DELETE FROM Projects WHERE projectID = %s', projectID)

        db.get_db().commit()
        return jsonify({'message': f'Project {projectID} successfully deleted'}), 200

    except Exception as e:

        db.get_db().rollback()
        current_app.logger.error(f'Error deleting project: {str(e)}')
        return jsonify({'error': 'Failed to delete project'}), 500








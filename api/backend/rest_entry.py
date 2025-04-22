from flask import Flask

from backend.db_connection import db
from backend.products.products_routes import products
from backend.average_persons.average_persons_routes import average_persons
from backend.compliance.compliance_routes import compliance
from backend.compliance_rules.compliance_rules_routes import compliance_rules
from backend.education.education_routes import education
from backend.investors.investor_routes import investors
from backend.projects.projects_routes import projects
from backend.transactions.transactions_routes import transactions
from backend.wallet.wallet_routes import wallet
from backend.withdrawals.withdrawals_routes import withdrawals
import os
from dotenv import load_dotenv

def create_app():
    app = Flask(__name__)

    # Load environment variables
    # This function reads all the values from inside
    # the .env file (in the parent folder) so they
    # are available in this file.  See the MySQL setup 
    # commands below to see how they're being used.
    load_dotenv()

    # secret key that will be used for securely signing the session 
    # cookie and can be used for any other security related needs by 
    # extensions or your application
    # app.config['SECRET_KEY'] = 'someCrazyS3cR3T!Key.!'
    app.config['SECRET_KEY'] = os.getenv('SECRET_KEY')

    # # these are for the DB object to be able to connect to MySQL. 
    # app.config['MYSQL_DATABASE_USER'] = 'root'
    app.config['MYSQL_DATABASE_USER'] = os.getenv('DB_USER').strip()
    app.config['MYSQL_DATABASE_PASSWORD'] = os.getenv('MYSQL_ROOT_PASSWORD').strip()
    app.config['MYSQL_DATABASE_HOST'] = os.getenv('DB_HOST').strip()
    app.config['MYSQL_DATABASE_PORT'] = int(os.getenv('DB_PORT').strip())
    app.config['MYSQL_DATABASE_DB'] = os.getenv('coinshroud').strip()  # Change this to your DB name

    # Initialize the database object with the settings above. 
    app.logger.info('current_app(): starting the database connection')
    db.init_app(app)


    # Register the routes from each Blueprint with the app object
    # and give a url prefix to each
    app.logger.info('current_app(): registering blueprints with Flask app object.')   
    app.register_blueprint(average_persons, url_prefix='/average_persons')
    app.register_blueprint(products, url_prefix='/products')
    app.register_blueprint(compliance, url_prefix='/compliance')
    app.register_blueprint(compliance_rules, url_prefix='/rules')
    app.register_blueprint(education, url_prefix='/education')
    app.register_blueprint(investors, url_prefix='/investors')
    app.register_blueprint(projects, url_prefix='/projects')
    app.register_blueprint(transactions, url_prefix='/transactions')
    app.register_blueprint(wallet, url_prefix='/wallet')
    app.register_blueprint(withdrawals, url_prefix='/withdrawals')

    # Don't forget to return the app object
    return app


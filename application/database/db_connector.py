# Citation for the following code:
# Date: 06/08/2026
# Copied from Oregon State University Summer 2026 - CS340 Intro to Databases
# Week 6 Building Your Project UI - Exploration: Web Application Technology
# (Explain Degree of Originality): Copied/pasted the starter code
# Source URL: https://canvas.oregonstate.edu/courses/2051721/pages/exploration-web-application-technology-2

import os
import MySQLdb
from dotenv import load_dotenv

load_dotenv()

# Database credentials loaded from .env
host = os.getenv("DB_HOST")
user = os.getenv("DB_USER")
passwd = os.getenv("DB_PASSWORD")
db = os.getenv("DB_NAME")

# The function that gets credentials as input and returns a database object
def connectDB(host = host, user = user, passwd = passwd, db = db):
    '''
    connects to a database and returns a database object
    '''
    dbConnection = MySQLdb.connect(host,user,passwd,db)
    return dbConnection

# Gets a database connection, a query and if exists query parameters. Then executes the query of the database.
# Returns a Cursor object.
def query(dbConnection = None, query = None, query_params = ()):
    '''
    executes a given SQL query on the given db connection and returns a Cursor object
    dbConnection: a MySQLdb connection object created by connectDB()
    query: string containing SQL query
    returns: A Cursor object as specified at https://www.python.org/dev/peps/pep-0249/#cursor-objects.
    You need to run .fetchall() or .fetchone() on that object to actually acccess the results.
    '''
    # If there is no database connection established prompts the user with an error message and returns None.
    if dbConnection is None:
        print("No connection to the database found! Have you called connectDB() first?")
        return None

    # If there isn't a query given as a parameter prompts the user with an error message and returns None.
    if query is None or len(query.strip()) == 0:
        print("query is empty! Please pass a SQL query in query")
        return None

    # If there is a database connection and query. Prints what query operation is being executed with parameters on to the screen.
    print("Executing %s with %s" % (query, query_params));

    # Create a cursor to execute query. Why? Because apparently they optimize execution by retaining a reference according to PEP0249.
    cursor = dbConnection.cursor(MySQLdb.cursors.DictCursor)

    # Sanitize the query before executing it.
    cursor.execute(query, query_params)
    
    # Commit any changes to the database.
    dbConnection.commit()
    
    # Returns the cursor object.
    return cursor
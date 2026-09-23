# Citation for the following code:
# Date: 06/08/2026
# Copied from Oregon State University Summer 2026 - CS340 Intro to Databases
# Week 6 Building Your Project UI - Exploration: Web Application Technology
# (Explain Degree of Originality): Copied/pasted the starter code
# Source URL: https://canvas.oregonstate.edu/courses/2051721/pages/exploration-web-application-technology-2

# ############################################################
# ########################## SETUP ###########################
# ############################################################

# import required methods/objects from flask and db_connector
from flask import Flask, render_template, request, redirect
import database.db_connector as db

# Define the port the app will run on.
PORT = 1923

# Create an App using the Python's Flask library.
app = Flask(__name__)

# ############################################################
# ###################### ROUTE HANDLERS ######################
# ######################## READ ROUTES #######################
# ############################################################


@app.route("/", methods=["GET"])
def home():
    try:
        return render_template("home.j2")

    except Exception as e:
        print(f"Error rendering page: {e}")
        return "An error occurred while rendering the page.", 500


@app.route("/animals", methods=["GET"])
def animals():
    try:
        # Open our database connection
        dbConnection = db.connectDB()  

        # Get all the columns from the Animals table.
        query1 = "SELECT * FROM Animals ORDER BY animalID;"
        animals = db.query(dbConnection, query1).fetchall()

        # Render the animals.j2 file, and also send the renderer
        # animals object that contains all the columns and rows
        return render_template(
            "animals.j2", animals=animals
        )

    # If an error occurs throws an exception. Prompts the user with the error.
    # Returns a string and the HTTP status code 500 (Internal server error).
    except Exception as e:
        print(f"Error executing queries: {e}")
        return "An error occurred while executing the database queries.", 500

    finally:
        # Close the DB connection, if it exists
        if "dbConnection" in locals() and dbConnection:
            dbConnection.close()


@app.route("/employees", methods=["GET"])
def employees():
    try:
        # Open our database connection
        dbConnection = db.connectDB()  

        # Get all the columns from the Employees table.
        query1 = "SELECT * FROM Employees ORDER BY employeeID;"
        employees = db.query(dbConnection, query1).fetchall()

        # Render the employees.j2 file, and also send the renderer
        # employees object that contains all the columns and rows.
        return render_template(
            "employees.j2", employees=employees
        )

    # If an error occurs throws an exception. Prompts the user with the error.
    # Returns a string and the HTTP status code 500 (Internal server error).
    except Exception as e:
        print(f"Error executing queries: {e}")
        return "An error occurred while executing the database queries.", 500

    finally:
        # Close the DB connection, if it exists
        if "dbConnection" in locals() and dbConnection:
            dbConnection.close()


@app.route("/feeds", methods=["GET"])
def feeds():
    try:
        # Open our database connection
        dbConnection = db.connectDB()
        # Create and execute our query. get all the columns from Feeds.
        query1 = "SELECT * FROM Feeds ORDER BY feedID;"
        feeds = db.query(dbConnection, query1).fetchall()

        # Render the feeds.j2 file, and also send the renderer
        # feeds object that contains all the columns and rows of the Feeds.
        return render_template(
            "feeds.j2", feeds=feeds
        )

    # If an error occurs throws an exception. Prompts the user with the error.
    # Returns a string and the HTTP status code 500 (Internal server error).
    except Exception as e:
        print(f"Error executing queries: {e}")
        return "An error occurred while executing the database queries.", 500

    finally:
        # Close the DB connection, if it exists
        if "dbConnection" in locals() and dbConnection:
            dbConnection.close()


@app.route("/employeefeedings", methods=["GET"])
def employeefeedings():
    try:
        # Open our database connection
        dbConnection = db.connectDB()

        # Create and execute our queries.
        # In query1 we get all the columns from the EmployeeFeedings table.
        # In query2 we get all the columns from the Employees table.
        # In query3 we get all the columns from the FeedingEvents table.
        query1 = "SELECT * FROM EmployeeFeedings ORDER BY employeeFeedingID;"
        query2 = "SELECT * FROM Employees ORDER BY employeeID;"
        query3 = "SELECT * FROM FeedingEvents ORDER BY feedingEventID;"
        employeefeedings = db.query(dbConnection, query1).fetchall()
        employees = db.query(dbConnection, query2).fetchall()
        feedingevents = db.query(dbConnection, query3).fetchall()

        # In query4 we join EmployeeFeedings, Employees and Feeding Events.
        query4 = (""" SELECT EmployeeFeedings.employeeFeedingID, EmployeeFeedings.employeeID, Employees.firstName, Employees.lastName, EmployeeFeedings.feedingEventID, FeedingEvents.feedEventTime 
                    FROM EmployeeFeedings
                    INNER JOIN Employees ON EmployeeFeedings.employeeID=Employees.employeeID
                    INNER JOIN FeedingEvents ON EmployeeFeedings.feedingEventID=FeedingEvents.feedingEventID ORDER BY EmployeeFeedings.employeeFeedingID;""")
        employeefeedingsjoined = db.query(dbConnection, query4).fetchall()

        # Render the employeefeedings.j2 file, and also send the renderer
        # a couple objects that contains employeefeedings, employees and 
        # feedingevents information.
        return render_template(
            "employeefeedings.j2", employeefeedings=employeefeedings,
            employees=employees, feedingevents=feedingevents,
            employeefeedingsjoined=employeefeedingsjoined
        )

    # If an error occurs throws an exception. Prompts the user with the error.
    # Returns a string and the HTTP status code 500 (Internal server error).
    except Exception as e:
        print(f"Error executing queries: {e}")
        return "An error occurred while executing the database queries.", 500

    finally:
        # Close the DB connection, if it exists
        if "dbConnection" in locals() and dbConnection:
            dbConnection.close()


@app.route("/feedingevents", methods=["GET"])
def feedingevents():
    try:
        # Open our database connection
        dbConnection = db.connectDB()

        # Create and execute our queries.
        # In query1 we get all the columns from the FeedingEvents table.
        # In query2 we get all the columns from the Feeds table.
        # In query3 we get all the columns from the Animals table.
        query1 = "SELECT * FROM FeedingEvents ORDER BY feedingEventID;"
        query2 = "SELECT * FROM Feeds ORDER BY feedID;"
        query3 = "SELECT * FROM Animals ORDER BY animalID;"
        feedingevents = db.query(dbConnection, query1).fetchall()
        feeds = db.query(dbConnection, query2).fetchall()
        animals = db.query(dbConnection, query3).fetchall()

        # In query4 we join FeedingEvents, Animals and Feeds tables.
        query4 = (""" SELECT FeedingEvents.feedingEventID, FeedingEvents.feedEventTime, FeedingEvents.feedID, Feeds.feedName, FeedingEvents.animalID, Animals.animalName 
        FROM FeedingEvents
        INNER JOIN Feeds ON FeedingEvents.feedID=Feeds.feedID
        INNER JOIN Animals ON FeedingEvents.animalID=Animals.animalID ORDER BY FeedingEvents.feedingEventID""")
        feedingeventsjoined = db.query(dbConnection, query4).fetchall()

        print(feedingeventsjoined)

        # Render the feedingevents.j2 file, and also send the renderer
        # a couple objects that contains feedingevents, feeds and animals info.
        return render_template(
            "feedingevents.j2", feedingevents=feedingevents, feeds=feeds,
            animals=animals, feedingeventsjoined=feedingeventsjoined
        )

    # If an error occurs throws an exception. Prompts the user with the error.
    # Returns a string and the HTTP status code 500 (Internal server error).
    except Exception as e:
        print(f"Error executing queries: {e}")
        return "An error occurred while executing the database queries.", 500

    finally:
        # Close the DB connection, if it exists
        if "dbConnection" in locals() and dbConnection:
            dbConnection.close()


# ############################################################
# ######################## READ ROUTES #######################
# ############################################################


@app.route("/resetdatabase", methods=["GET"])
def resetdatabase():
    try:
        # Open our database connection
        dbConnection = db.connectDB()
        # Create and execute our queries.
        # In query1 resets the database by calling the stored procedure
        # called sp_load_aquarium_db()
        query1 = "CALL sp_load_aquariumdb();"
        db.query(dbConnection, query1)

        return render_template("home.j2")

    # If an error occurs throws an exception. Prompts the user with the error.
    # Returns a string and the HTTP status code 500 (Internal server error).
    except Exception as e:
        print(f"Error executing queries: {e}")
        return "An error occurred while resetting the database.", 500

    finally:
        # Close the DB connection, if it exists
        if "dbConnection" in locals() and dbConnection:
            dbConnection.close()


@app.route("/deletedaisy", methods=["GET"])
def deletedaisy():
    try:
        # Open our database connection
        dbConnection = db.connectDB()

        # Create and execute our queries.
        # In query1 deletes Daisy from the table Animals
        query1 = "CALL sp_delete_daisy();"
        db.query(dbConnection, query1)

        # Create and execute our query. In query1 we get all the columns.
        # This time we'll see Daisy is deleted from the table.
        query1 = "SELECT * FROM Animals;"
        animals = db.query(dbConnection, query1).fetchall()

        # Render the animals.j2 file, and also send the renderer
        # animals object that contains all the columns and rows of the table.
        return render_template(
            "animals.j2", animals=animals
        )

    # If an error occurs throws an exception. Prompts the user with the error.
    # Returns a string and the HTTP status code 500 (Internal server error).
    except Exception as e:
        print(f"Error executing queries: {e}")
        return "An error occurred while executing the database queries.", 500

    finally:
        # Close the DB connection, if it exists
        if "dbConnection" in locals() and dbConnection:
            dbConnection.close()


# ######################## CREATE ROUTES ##############################
# Citation for CREATE Routes
# Date: 12/08/2026
# Copied and adapted from OSU Summer 2026 CS340 Intro to databases
# Module Week 8 - DB Performance and Query Optimization + Project Development
# (Explain Degree of Originality): Copied/pasted and adapted the starter code
# Source URL: https://canvas.oregonstate.edu/courses/2051721/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=26923368
# ####################################################################


# Create a new animal
@app.route("/animals/create", methods=["POST"])
def create_animal():
    try:
        dbConnection = db.connectDB()  # Open our database connection
        cursor = dbConnection.cursor()

        # Get form data
        name = request.form["create_animal_name"]
        species = request.form["create_animal_species"]

        # Create and execute our queries
        # Using parameterized queries (Prevents SQL injection attacks)
        query1 = "CALL sp_insertAnimal(%s, %s, @new_id);"
        cursor.execute(query1, (name, species))

        # Store ID of last inserted row
        new_id = cursor.fetchone()[0]

        # Consume the result set (if any) before running the next query
        cursor.nextset()  # Move to the next result set (for CALL statements)

        dbConnection.commit()  # commit the transaction

        # Print the created animals information to the server terminal.
        print(f"CREATE Animals. ID: {new_id} Name: {name} Species: {species}")

        # Redirect the user to the updated webpage
        return redirect("/animals")

    # Checks for exceptions. And if there is an error return 500 and the error.
    except Exception as e:
        print(f"Error executing queries: {e}")
        return ("An error occurred while inserting an animal to the Animals table.", 500,)
    finally:
        # Close the DB connection, if it exists
        if "dbConnection" in locals() and dbConnection:
            dbConnection.close()


# Create a new employee
@app.route("/employees/create", methods=["POST"])
def create_employee():
    try:
        dbConnection = db.connectDB()  # Open our database connection
        cursor = dbConnection.cursor()

        # Get form data first and last name
        fname = request.form["create_employee_first_name"]
        lname = request.form["create_employee_last_name"]

        # Get employment time part-time, full-time, as-needed
        employment_type = request.form["create_employee_status"]

        # Try to make age an int if not make in None
        try:
            age = int(request.form["create_employee_age"])
        except ValueError:
            age = None

        # Create and execute our queries
        # Using parameterized queries (Prevents SQL injection attacks)
        query1 = "CALL sp_insertEmployee(%s, %s, %s, %s, @new_id);"
        cursor.execute(query1, (fname, lname, age, employment_type))

        # Store ID of last inserted row
        new_id = cursor.fetchone()[0]

        # Consume the result set (if any) before running the next query
        cursor.nextset()  # Move to the next result set (for CALL statements)

        dbConnection.commit()  # commit the transaction

        # Print the created employee information to the server terminal.
        print(f"CREATE Employees. ID: {new_id} First Name: {fname} Last Name: {lname} Age: {age} Employment Type: {employment_type}")

        # Redirect the user to the updated webpage
        return redirect("/employees")

    # Checks for exceptions. And if there is an error return 500 and the error.
    except Exception as e:
        print(f"Error executing queries: {e}")
        return ("An error occurred while inserting an employee to the Employees table.", 500,)
    finally:
        # Close the DB connection, if it exists
        if "dbConnection" in locals() and dbConnection:
            dbConnection.close()


# Create a new feed
@app.route("/feeds/create", methods=["POST"])
def create_feed():
    try:
        dbConnection = db.connectDB()  # Open our database connection
        cursor = dbConnection.cursor()

        # Get form data feed name and description
        feedName = request.form["create_feed_name"]
        feedDescription = request.form["create_feed_description"]

        # Create and execute our queries
        # Using parameterized queries (Prevents SQL injection attacks)
        query1 = "CALL sp_insertFeed(%s, %s, @new_id);"
        cursor.execute(query1, (feedName, feedDescription))

        # Store ID of last inserted row
        new_id = cursor.fetchone()[0]

        # Consume the result set (if any) before running the next query
        cursor.nextset()  # Move to the next result set (for CALL statements)

        dbConnection.commit()  # commit the transaction

        # Print the created feed information to the server terminal.
        print(f"CREATE Feeds. ID: {new_id} Feed Name: {feedName} Feed Description: {feedDescription}")

        # Redirect the user to the updated webpage
        return redirect("/feeds")

    # Checks for exceptions. And if there is an error return 500.
    except Exception as e:
        print(f"Error executing queries: {e}")
        return ("An error occurred while inserting a feed to the Feeds table.", 500,)
    finally:
        # Close the DB connection, if it exists
        if "dbConnection" in locals() and dbConnection:
            dbConnection.close()


# Create a new feedingevent
@app.route("/feedingevents/create", methods=["POST"])
def create_feeding_event():
    try:
        dbConnection = db.connectDB()  # Open our database connection
        cursor = dbConnection.cursor()

        # Get form data feed name and description
        feedingEventTime =  request.form["create_feeding_event_time"]
        animalID = request.form["create_feeding_event_animalid"]
        feedID = request.form["create_feeding_event_feedid"]

        # Create and execute our queries
        # Using parameterized queries (Prevents SQL injection attacks)
        query1 = "CALL sp_insertFeedingEvent(%s, %s, %s, @new_id);"
        cursor.execute(query1, (feedingEventTime, animalID, feedID))

        # Store ID of last inserted row
        new_id = cursor.fetchone()[0]

        # Consume the result set (if any) before running the next query
        cursor.nextset()  # Move to the next result set (for CALL statements)

        dbConnection.commit()  # commit the transaction

        # Print the created feed information to the server terminal.
        print(f"CREATE Feeding Event. ID: {new_id} Feeding Event Time: {feedingEventTime} Animal ID: {animalID} Feed ID: {feedID}")

        # Redirect the user to the updated webpage
        return redirect("/feedingevents")

    # Checks for exceptions. And if there is an error return 500.
    except Exception as e:
        print(f"Error executing queries: {e}")
        return ("An error occurred while inserting a feeding event to the Feeding Events table.", 500,)

    finally:
        # Close the DB connection, if it exists
        if "dbConnection" in locals() and dbConnection:
            dbConnection.close()


# Create a new employee feeding
@app.route("/employeefeedings/create", methods=["POST"])
def create_employee_feeding():
    try:
        dbConnection = db.connectDB()  # Open our database connection
        cursor = dbConnection.cursor()

        # Get form data feed name and description
        employeeID = request.form["create_employee_feeding_employeeid"]
        feedingID = request.form["create_employee_feeding_feedingeventid"]

        # Create and execute our queries
        # Using parameterized queries (Prevents SQL injection attacks)
        query1 = "CALL sp_insertEmployeeFeeding(%s, %s, @new_id);"
        cursor.execute(query1, (employeeID, feedingID))

        # Store ID of last inserted row
        new_id = cursor.fetchone()[0]

        # Consume the result set (if any) before running the next query
        cursor.nextset()  # Move to the next result set (for CALL statements)

        dbConnection.commit()  # commit the transaction

        # Print the created feed information to the server terminal.
        print(f"CREATE Employee Feeding. ID: {new_id} Employee ID: {employeeID} Feeding Event ID: {feedingID}")

        # Redirect the user to the updated webpage
        return redirect("/employeefeedings")

    # Checks for exceptions. And if there is an error return 500.
    except Exception as e:
        print(f"Error executing queries: {e}")
        return ("An error occurred while inserting a employee feeding to the Employee Feeding table.", 500,)

    finally:
        # Close the DB connection, if it exists
        if "dbConnection" in locals() and dbConnection:
            dbConnection.close()

# ######################## DELETE ROUTES ##############################
# Citation for DELETE Routes
# Date: 12/08/2026
# Copied and adapted from OSU Summer 2026 CS340 Intro to databases
# Module Week 8 - DB Performance and Query Optimization + Project Development
# (Explain Degree of Originality): Copied/pasted and adapted the starter code
# Source URL: https://canvas.oregonstate.edu/courses/2051721/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=26923368
# ###################################################################


# Delete an animal
@app.route("/animals/delete", methods=["POST"])
def delete_animal():
    try:
        dbConnection = db.connectDB()  # Open our database connection
        cursor = dbConnection.cursor()

        # Get form data
        animal_id = int(request.form["delete_animal_id"])
        animal_name = request.form["delete_animal_name"]
        animal_species = request.form["delete_animal_species"]

        # Create and execute our queries
        # Using parameterized queries (Prevents SQL injection attacks)
        query1 = "CALL sp_deleteAnimal(%s);"
        cursor.execute(query1, (animal_id,))

        dbConnection.commit()  # commit the transaction

        print(f"DELETE Animal. ID: {animal_id} Animal Name: {animal_name} Animal Species: {animal_species}")

        # Redirect the user to the updated webpage
        return redirect("/animals")

    except Exception as e:
        print(f"Error executing queries: {e}")
        return (
            "An error occurred while deleteing an animal from the Animals table.",
            500,)

    finally:
        # Close the DB connection, if it exists
        if "dbConnection" in locals() and dbConnection:
            dbConnection.close()


# Delete an employee
@app.route("/employees/delete", methods=["POST"])
def delete_employee():
    try:
        dbConnection = db.connectDB()  # Open our database connection
        cursor = dbConnection.cursor()

        # Get form data
        employee_id = int(request.form["delete_person_id"])
        employee_name = request.form["delete_person_name"]
        employee_age = request.form["delete_person_age"]
        employee_type = request.form["delete_person_employment"]

        # Create and execute our queries
        # Using parameterized queries (Prevents SQL injection attacks)
        query1 = "CALL sp_deleteEmployee(%s);"
        cursor.execute(query1, (employee_id,))

        dbConnection.commit()  # commit the transaction

        print(f"DELETE Employee. ID: {employee_id} Employee Name: {employee_name} Employee Age: {employee_age} Employee Type: {employee_type}")

        # Redirect the user to the updated webpage
        return redirect("/employees")

    except Exception as e:
        print(f"Error executing queries: {e}")
        return (
            "An error occurred while deleting an employee from the Employees table.",
            500,)

    finally:
        # Close the DB connection, if it exists
        if "dbConnection" in locals() and dbConnection:
            dbConnection.close()


# Delete a feed
@app.route("/feeds/delete", methods=["POST"])
def delete_feed():
    try:
        dbConnection = db.connectDB()  # Open our database connection
        cursor = dbConnection.cursor()

        # Get form data
        feed_id = int(request.form["delete_feed_id"])
        feed_name = request.form["delete_feed_name"]
        feed_description = request.form["delete_feed_description"]

        # Create and execute our queries
        # Using parameterized queries (Prevents SQL injection attacks)
        query1 = "CALL sp_deleteFeed(%s);"
        cursor.execute(query1, (feed_id,))

        dbConnection.commit()  # commit the transaction

        print(f"DELETE Feed. ID: {feed_id} Feed Name: {feed_name} Feed Description: {feed_description} ")

        # Redirect the user to the updated webpage
        return redirect("/feeds")

    except Exception as e:
        print(f"Error executing queries: {e}")
        return (
            "An error occurred while deleting a feed from the Feeds table.",
            500,)

    finally:
        # Close the DB connection, if it exists
        if "dbConnection" in locals() and dbConnection:
            dbConnection.close()


# Delete a feeding event
@app.route("/feedingevents/delete", methods=["POST"])
def delete_feeding_event():
    try:
        dbConnection = db.connectDB()  # Open our database connection
        cursor = dbConnection.cursor()

        # Get form data
        feeding_event_id = int(request.form["delete_feeding_event_id"])
        feeding_event_time = request.form["delete_feeding_event_time"]
        animal_id = request.form["delete_feeding_event_animal_id"]
        feed_id = request.form["delete_feeding_event_feed_id"]

        # Create and execute our queries
        # Using parameterized queries (Prevents SQL injection attacks)
        query1 = "CALL sp_deleteFeedingEvent(%s);"
        cursor.execute(query1, (feeding_event_id,))

        dbConnection.commit()  # commit the transaction

        print(f"DELETE Feeding Event ID: {feeding_event_id} Feeding Event Time: {feeding_event_time} Animal ID: {animal_id} Feed ID: {feed_id} ")

        # Redirect the user to the updated webpage
        return redirect("/feedingevents")

    except Exception as e:
        print(f"Error executing queries: {e}")
        return (
            "An error occurred while deleting a feeding event from the FeedingEvents table.",
            500,
        )

    finally:
        # Close the DB connection, if it exists
        if "dbConnection" in locals() and dbConnection:
            dbConnection.close()


# Delete an employee feeding
@app.route("/employeefeedings/delete", methods=["POST"])
def delete_employee_feeding():
    try:
        dbConnection = db.connectDB()  # Open our database connection
        cursor = dbConnection.cursor()

        # Get form data
        employee_feeding_id = int(request.form["delete_employeefeeding_id"])
        employee_id = request.form["delete_employeefeeding_employeeID"]
        feeding_event_id = request.form["delete_employeefeeding_feedingEventID"]

        # Create and execute our queries
        # Using parameterized queries (Prevents SQL injection attacks)
        query1 = "CALL sp_deleteEmployeeFeeding(%s);"
        cursor.execute(query1, (employee_feeding_id,))

        dbConnection.commit()  # commit the transaction

        print(f"DELETE Employee Feeding ID: {employee_feeding_id} Employee ID: {employee_id} Feeding Event ID: {feeding_event_id}")

        # Redirect the user to the updated webpage
        return redirect("/employeefeedings")

    except Exception as e:
        print(f"Error executing queries: {e}")
        return (
            "An error occurred while deleting an employee feeding from the EmployeeFeedings table.", 500,)

    finally:
        # Close the DB connection, if it exists
        if "dbConnection" in locals() and dbConnection:
            dbConnection.close()

# ######################## UPDATE ROUTES ##############################
# Citation for UPDATE Routes
# Date: 12/08/2026
# Copied and adapted from OSU Summer 2026 CS340 Intro to databases
# Module Week 8 - DB Performance and Query Optimization + Project Development
# (Explain Degree of Originality): Copied/pasted and adapted the starter code
# Source URL: https://canvas.oregonstate.edu/courses/2051721/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=26923368
# ####################################################################


# Update an Animal
@app.route("/animals/update", methods=["POST"])
def update_animal():
    try:
        dbConnection = db.connectDB()  # Open our database connection
        cursor = dbConnection.cursor()

        # Get form data
        animal_id = int(request.form["update_animal_id"])
        animal_name = request.form["update_animal_name"]
        animal_species = request.form["update_animal_species"]

        # Create and execute our queries
        # Using parameterized queries (Prevents SQL injection attacks)
        query1 = "CALL sp_updateAnimal(%s, %s, %s);"
        cursor.execute(query1, (animal_id, animal_name, animal_species))

        # Consume the result set (if any) before running the next query
        cursor.nextset()  # Move to the next result set (for CALL statements)

        dbConnection.commit()  # commit the transaction

        query2 = "SELECT animalName, species FROM Animals WHERE animalID = %s;"
        cursor.execute(query2, (animal_id,))
        rows = cursor.fetchone()  # Fetch name info on updated person

        print(f"UPDATE Animals. ID: {animal_id} Name: {rows[0]} Species: {rows[1]}")

        # Redirect the user to the updated webpage
        return redirect("/animals")

    except Exception as e:
        print(f"Error executing queries: {e}")
        return (
            "An error occurred while updating an animal from Animals table.", 500,)

    finally:
        # Close the DB connection, if it exists
        if "dbConnection" in locals() and dbConnection:
            dbConnection.close()


# Update an Employee
@app.route("/employees/update", methods=["POST"])
def update_employee():
    try:
        dbConnection = db.connectDB()  # Open our database connection
        cursor = dbConnection.cursor()

        # Get form data
        employee_id = int(request.form["update_employee_id"])
        employee_first_name = request.form["update_employee_first_name"]
        employee_last_name = request.form["update_employee_last_name"]
        employee_age = int(request.form["update_employee_age"])
        employee_job_status = request.form["update_employee_employment_status"]

        # Create and execute our queries
        # Using parameterized queries (Prevents SQL injection attacks)
        query1 = "CALL sp_updateEmployee(%s, %s, %s, %s, %s);"
        cursor.execute(query1, (employee_id, employee_first_name,
                                employee_last_name, employee_age,
                                employee_job_status))

        # Consume the result set (if any) before running the next query
        cursor.nextset()  # Move to the next result set (for CALL statements)

        dbConnection.commit()  # commit the transaction

        query2 = "SELECT firstName, lastName, age, employmentStatus FROM Employees WHERE employeeID = %s;"
        cursor.execute(query2, (employee_id,))
        rows = cursor.fetchone()  # Fetch name info on updated person

        print(f"UPDATE Animals. ID: {employee_id} First Name: {rows[0]} First Name: {rows[1]} Age: {rows[2]} Employment Status {rows[3]}")

        # Redirect the user to the updated webpage
        return redirect("/employees")

    except Exception as e:
        print(f"Error executing queries: {e}")
        return (
            "An error occurred while updating an employee from "
            "Employees table.", 500,)

    finally:
        # Close the DB connection, if it exists
        if "dbConnection" in locals() and dbConnection:
            dbConnection.close()


# Update a Feed
@app.route("/feeds/update", methods=["POST"])
def update_feed():
    try:
        dbConnection = db.connectDB()  # Open our database connection
        cursor = dbConnection.cursor()

        # Get form data
        feed_id = int(request.form["update_feed_id"])
        feed_name = request.form["update_feed_name"]
        feed_description = request.form["update_feed_description"]

        # Create and execute our queries
        # Using parameterized queries (Prevents SQL injection attacks)
        query1 = "CALL sp_updateFeed(%s, %s, %s);"
        cursor.execute(query1, (feed_id, feed_name, feed_description))

        # Consume the result set (if any) before running the next query
        cursor.nextset()  # Move to the next result set (for CALL statements)

        dbConnection.commit()  # commit the transaction

        query2 = "SELECT feedName, description FROM Feeds WHERE feedID = %s;"
        cursor.execute(query2, (feed_id,))
        rows = cursor.fetchone()  # Fetch name info on updated person

        print(f"UPDATE Feeds. ID: {feed_id} Name: {rows[0]} Description: {rows[1]}")

        # Redirect the user to the updated webpage
        return redirect("/feeds")

    except Exception as e:
        print(f"Error executing queries: {e}")
        return (
            "An error occurred while updating a feed from Feeds table.",
            500,)

    finally:
        # Close the DB connection, if it exists
        if "dbConnection" in locals() and dbConnection:
            dbConnection.close()


# Update an employee feeding
@app.route("/employeefeedings/update", methods=["POST"])
def update_employee_feedings():
    try:
        dbConnection = db.connectDB()  # Open our database connection
        cursor = dbConnection.cursor()

        # Get form data
        employee_feeding_id = int(request.form["update_employee_feeding_id"])
        employee_id = int(request.form["update_employee_feeding_employeeid"])
        feeding_event_id = int(request.form["update_employee_feeding_feedingeventid"])

        # Create and execute our queries
        # Using parameterized queries (Prevents SQL injection attacks)
        query1 = "CALL sp_updateEmployeeFeeding(%s, %s, %s);"
        cursor.execute(query1, (employee_feeding_id, employee_id, feeding_event_id))

        # Consume the result set (if any) before running the next query
        cursor.nextset()  # Move to the next result set (for CALL statements)

        dbConnection.commit()  # commit the transaction

        query2 = "SELECT employeeID, feedingEventID FROM EmployeeFeedings WHERE employeeFeedingID = %s;"
        cursor.execute(query2, (employee_feeding_id,))
        rows = cursor.fetchone()  # Fetch name info on updated person

        print(f"UPDATE Employee Feeding. ID: {employee_feeding_id} Employee ID: {rows[0]} Feeding Event ID: {rows[1]}")

        # Redirect the user to the updated webpage
        return redirect("/employeefeedings")

    except Exception as e:
        print(f"Error executing queries: {e}")
        return (
            "An error occurred while updating an employee feeding from EmployeeFeedings table.",
            500,)

    finally:
        # Close the DB connection, if it exists
        if "dbConnection" in locals() and dbConnection:
            dbConnection.close()


# Update a feeding event
@app.route("/feedingevents/update", methods=["POST"])
def update_feeding_event():
    try:
        dbConnection = db.connectDB()  # Open our database connection
        cursor = dbConnection.cursor()

        # Get form data
        feeding_event_id = int(request.form["update_feeding_event_id"])
        feeding_event_time = request.form["update_feeding_event_time"]
        animal_id = int(request.form["update_feeding_event_animalid"])
        feed_id = int(request.form["update_feeding_event_feedid"])

        print(feeding_event_id, feeding_event_time, animal_id, feed_id)

        # Create and execute our queries
        # Using parameterized queries (Prevents SQL injection attacks)
        query1 = "CALL sp_updateFeedingEvent(%s, %s, %s, %s);"
        cursor.execute(query1, (feeding_event_id, feeding_event_time, animal_id, feed_id))

        # Consume the result set (if any) before running the next query
        cursor.nextset()  # Move to the next result set (for CALL statements)

        dbConnection.commit()  # commit the transaction

        query2 = "SELECT feedEventTime, animalID, feedID FROM FeedingEvents WHERE feedingEventID = %s;"
        cursor.execute(query2, (feeding_event_id,))
        rows = cursor.fetchone()  # Fetch name info on updated person

        print(f"UPDATE Feeding Event. ID: {feeding_event_id} Feeding Event Time: {rows[0]} Animal ID: {rows[1]} Feed ID: {rows[2]}")

        # Redirect the user to the updated webpage
        return redirect("/feedingevents")

    except Exception as e:
        print(f"Error executing queries: {e}")
        return (
            "An error occurred while updating a feeding event from FeedingEvents table.",
            500,)

    finally:
        # Close the DB connection, if it exists
        if "dbConnection" in locals() and dbConnection:
            dbConnection.close()


# ############################################################
# ###################### RUN APPLICATION #####################
# ############################################################
if __name__ == "__main__":
    # Start the app with the defined port.
    app.run(
        port=PORT, debug=True
    )  # debug is an optional parameter. Behaves like nodemon in Node.

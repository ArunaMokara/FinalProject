from bottle import Bottle, request, template, redirect
import sqlite3

app = Bottle()

# SQLite Database Connection
def connect_db():
    return sqlite3.connect("company.db")

# Index route
@app.route('/')
def index():
    connection = connect_db()
    cursor = connection.cursor()

    # Fetch all projects with their members
    cursor.execute('''
        SELECT Projects.ProjectID, ProjectName, StartDate, EndDate, Budget, 
               GROUP_CONCAT(EmployeeID || ': ' || Role, ', ') AS Members
        FROM Projects
        LEFT JOIN ProjectMembers ON Projects.ProjectID = ProjectMembers.ProjectID
        GROUP BY Projects.ProjectID
    ''')

    projects = cursor.fetchall()

    connection.close()

    return template('index', projects=projects)

# Insert route
@app.route('/add_project', method='POST')
def add_project():
    project_name = request.forms.get('project_name')
    start_date = request.forms.get('start_date')
    end_date = request.forms.get('end_date')
    budget = request.forms.get('budget')

    connection = connect_db()
    cursor = connection.cursor()

    # Insert project into Projects table
    cursor.execute('''
        INSERT INTO Projects (ProjectName, StartDate, EndDate, Budget)
        VALUES (?, ?, ?, ?)
    ''', (project_name, start_date, end_date, budget))

    project_id = cursor.lastrowid
   # Insert project members into ProjectMembers table
    for key in request.forms.keys():
        if key.startswith('EmployeeID_') and request.forms.get(key):
            value = request.forms.get(key)
            print(f"Form Data: {key} - {value}")
            print("values",value)
            employee_id = key.split('_')[1]
            role_key = 'role_' + employee_id
            role = request.forms.get(role_key)
            print(f"Adding member: Employee ID - {employee_id}, Role - {role}")
            cursor.execute('''
                INSERT INTO ProjectMembers (ProjectID, EmployeeID, Role)
                VALUES (?, ?, ?)
            ''', (project_id, value, role))


    # employee_id = request.forms.get('EmployeeID')
    # role = request.forms.get('role')
    # # Insert project members into ProjectMembers table
    # cursor.execute('''
    #         INSERT INTO ProjectMembers (ProjectID, EmployeeID, Role)
    #         VALUES (?, ?, ?)
    #     ''', (project_id, employee_id, role))

    connection.commit()
    connection.close()

    return index()

# Read route - View details of a specific project
@app.route('/project/<project_id>')
def view_project(project_id):
    connection = connect_db()
    cursor = connection.cursor()

    # Fetch project details with its members
    cursor.execute('''
        SELECT Projects.ProjectID, ProjectName, StartDate, EndDate, Budget, 
               GROUP_CONCAT(EmployeeID || ': ' || Role, ', ') AS Members
        FROM Projects
        LEFT JOIN ProjectMembers ON Projects.ProjectID = ProjectMembers.ProjectID
        WHERE Projects.ProjectID = ?
        GROUP BY Projects.ProjectID
    ''', (project_id,))

    project = cursor.fetchone()

    connection.close()

    return template('view_project', project=project)

# Update route - Update details of a specific project
@app.route('/edit_project/<project_id>', method='GET')
def edit_project_form(project_id):
    connection = connect_db()
    cursor = connection.cursor()

    # Fetch project details
    cursor.execute('SELECT * FROM Projects WHERE ProjectID = ?', (project_id,))
    project = cursor.fetchone()

    # Fetch project members
    cursor.execute('''
        SELECT EmployeeID, Role FROM ProjectMembers
        WHERE ProjectID = ?
    ''', (project_id,))
    project_members = cursor.fetchall()

    connection.close()

    return template('edit_project', project=project, project_members=project_members)

@app.route('/edit_project/<project_id>', method='POST')
def edit_project(project_id):
    project_name = request.forms.get('project_name')
    start_date = request.forms.get('start_date')
    end_date = request.forms.get('end_date')
    budget = request.forms.get('budget')

    connection = connect_db()
    cursor = connection.cursor()

    # Update project details
    cursor.execute('''
        UPDATE Projects
        SET ProjectName = ?, StartDate = ?, EndDate = ?, Budget = ?
        WHERE ProjectID = ?
    ''', (project_name, start_date, end_date, budget, project_id))

    # Delete existing project members
    cursor.execute('DELETE FROM ProjectMembers WHERE ProjectID = ?', (project_id,))

    # Insert updated project members into ProjectMembers table
    for key in request.forms.keys():
        if key.startswith('EmployeeID_') and request.forms.get(key):
            value = request.forms.get(key)
            employee_id = key.split('_')[1]
            role_key = 'role_' + employee_id
            role = request.forms.get(role_key)
            cursor.execute('''
                INSERT INTO ProjectMembers (ProjectID, EmployeeID, Role)
                VALUES (?, ?, ?)
            ''', (project_id, value, role))

    connection.commit()
    connection.close()

    redirect('/')


# Delete route - Delete a specific project
@app.route('/delete_project/<project_id>')
def delete_project(project_id):
    connection = connect_db()
    cursor = connection.cursor()

    # Delete project and associated members
    cursor.execute('DELETE FROM Projects WHERE ProjectID = ?', (project_id,))
    cursor.execute('DELETE FROM ProjectMembers WHERE ProjectID = ?', (project_id,))

    connection.commit()
    connection.close()

    redirect('/')

# Run the Bottle app
if __name__ == '__main__':
    app.run(host='localhost', port=8080, debug=True)

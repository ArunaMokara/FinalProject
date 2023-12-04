import sqlite3

connection = sqlite3.connect("company.db")
cursor = connection.cursor()

# Drop existing tables if they exist
try:
    cursor.execute("DROP TABLE IF EXISTS ProjectMembers")
    cursor.execute("DROP TABLE IF EXISTS Projects")
except Exception as e:
    print(f"Error: {e}")

# Create Projects table
cursor.execute('''
    CREATE TABLE IF NOT EXISTS Projects (
        ProjectID INTEGER PRIMARY KEY,
        ProjectName VARCHAR(100),
        StartDate DATE,
        EndDate DATE,
        Budget DECIMAL(15,2)
    )
''')

# Create ProjectMembers table
cursor.execute('''
    CREATE TABLE IF NOT EXISTS ProjectMembers (
        ProjectMemberID INTEGER PRIMARY KEY AUTOINCREMENT,
        ProjectID INTEGER,
        EmployeeID INTEGER,
        Role VARCHAR(50),
        FOREIGN KEY (ProjectID) REFERENCES Projects (ProjectID),
        FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
    )
''')

# Insert sample projects
projects_data = [
    ('ProjectA', '2023-01-01', '2023-12-31', 50000.00),
    ('ProjectB', '2023-02-15', '2023-11-30', 75000.00),
    ('ProjectC', '2023-05-10', '2023-08-31', 30000.00),
]

cursor.executemany("INSERT INTO Projects (ProjectName, StartDate, EndDate, Budget) VALUES (?, ?, ?, ?)", projects_data)

# Insert sample project members
project_members_data = [
    (1, 1, 'Manager'),
    (2, 2, 'Developer'),
    (3, 3, 'Designer'),
    (2, 4, 'QA Tester'),
]

cursor.executemany("INSERT INTO ProjectMembers (ProjectID, EmployeeID, Role) VALUES (?, ?, ?)", project_members_data)

connection.commit()
connection.close()

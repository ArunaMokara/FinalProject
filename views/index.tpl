<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Project Management</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid black;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }
    </style>
</head>
<body>
    <h1>Project Management</h1>

    <h2>Projects</h2>
    <table>
        <thead>
            <tr>
                <th>Project Name</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Budget</th>
                <th>Members</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            % for project in projects:
                <tr>
                    <td><strong><a href="/project/{{ project[0] }}">{{ project[1] }}</a></strong></td>
                    <td>{{ project[2] }}</td>
                    <td>{{ project[3] }}</td>
                    <td>${{ project[4] }}</td>
                    <td>{{ project[5] }}</td>
                    <td>
                        <a href="/edit_project/{{ project[0] }}">Edit</a>
                        <a href="/delete_project/{{ project[0] }}" onclick="return confirm('Are you sure you want to delete this project?')">Delete</a>
                    </td>
                </tr>
            % end
        </tbody>
    </table>

    <h2>Add Project</h2>
    <form action="/add_project" method="post">
        <label for="project_name">Project Name:</label>
        <input type="text" name="project_name" required>
        <br>

        <label for="start_date">Start Date:</label>
        <input type="date" name="start_date" required>
        <br>

        <label for="end_date">End Date:</label>
        <input type="date" name="end_date" required>
        <br>

        <label for="budget">Budget:</label>
        <input type="number" name="budget" step="0.01" required>
        <br>

    <h3>Add Project Members</h3>
        <div id="projectMembersContainer">
        <!-- Initial set of input fields -->
        <input type="text" name="EmployeeID_1" placeholder="EmployeeID 1" required>
        <input type="text" name="role_1" placeholder="Role 1" required>
        <br>
    </div>

    <button type="button" onclick="addProjectMember()">Add Member</button>
     <br>
    <input type="submit" value="Add Project">
    </form>
    <!-- ... (submit button and other form closing tags) ... -->

    <script>
    let memberCount = 1;

    function addProjectMember() {
        memberCount++;

        const container = document.getElementById('projectMembersContainer');

        const employeeIDInput = document.createElement('input');
        employeeIDInput.type = 'text';
        employeeIDInput.name = `EmployeeID_${memberCount}`;
        employeeIDInput.placeholder = `EmployeeID ${memberCount}`;
        employeeIDInput.required = true;

        const roleInput = document.createElement('input');
        roleInput.type = 'text';
        roleInput.name = `role_${memberCount}`;
        roleInput.placeholder = `Role ${memberCount}`;
        roleInput.required = true;

        const lineBreak = document.createElement('br');

        container.appendChild(employeeIDInput);
        container.appendChild(roleInput);
        container.appendChild(lineBreak);
    }
</script>





    <br>
</body>
</html>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Project</title>
</head>
<body>
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

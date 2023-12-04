<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Project</title>
</head>
<body>
    <h1>Edit Project</h1>

    <form action="/edit_project/{{ project[0] }}" method="post">
        <label for="project_name">Project Name:</label>
        <input type="text" name="project_name" value="{{ project[1] }}" required>
        <br>

        <label for="start_date">Start Date:</label>
        <input type="date" name="start_date" value="{{ project[2] }}" required>
        <br>

        <label for="end_date">End Date:</label>
        <input type="date" name="end_date" value="{{ project[3] }}" required>
        <br>

        <label for="budget">Budget:</label>
        <input type="number" name="budget" step="0.01" value="{{ project[4] }}" required>
        <br>

        <h3>Project Members</h3>
        % for member in project_members:
            <label for="employee_id_{{ member[0] }}">Employee ID {{ member[0] }}:</label>
            <input type="text" name="EmployeeID_{{ member[0] }}" value="{{ member[0] }}" required>
            <label for="role_{{ member[0] }}">Role:</label>
            <input type="text" name="role_{{ member[0] }}" value="{{ member[1] }}" required>
            <br>
        % end

        <br>
        <input type="submit" value="Update Project">
    </form>

    <br>
    <a href="/">Back to Projects</a>
</body>
</html>

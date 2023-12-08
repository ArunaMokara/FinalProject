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
    <input type="text" id="searchInput" placeholder="Search projects...">
    <button onclick="searchProjects()">Search</button>
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
       <tbody id="projectTableBody">
            % for project in projects:
        <tr>
            <td>{{ project[1] }}</td>
            <td>{{ project[2] }}</td>
            <td>{{ project[3] }}</td>
            <td>${{ project[4] }}</td>
            <td>{{ project[5] }}</td>
            <td>
                <a href="/update_project/{{ project[0] }}">Update</a>
                <a href="/delete_project/{{ project[0] }}" onclick="return confirm('Are you sure you want to delete this project?')">Delete</a>
            </td>
        </tr>
         % end
       </tbody>
    </table>
   <h2><a href="/add_projects_members">Add Project</a></h2>
<script>
function searchProjects() {
    const input = document.getElementById('searchInput');
    const filter = input.value.toUpperCase();

    const table = document.getElementById('projectTableBody');
    const rows = table.getElementsByTagName('tr');

    for (let i = 0; i < rows.length; i++) {
        const cells = rows[i].getElementsByTagName('td');
        let display = false;
        for (let j = 0; j < cells.length; j++) {
            const cellValue = cells[j].textContent || cells[j].innerText;
            if (cellValue.toUpperCase().indexOf(filter) > -1) {
                display = true;
                break;
            }
        }
        rows[i].style.display = display ? '' : 'none';
    }
}
</script>

    <br>
</body>
</html>

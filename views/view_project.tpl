<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Project</title>
</head>
<body>
    <h1>Project Details</h1>

    <h2>{{ project[1] }}</h2>
    <p>Start Date: {{ project[2] }}, End Date: {{ project[3] }}, Budget: ${{ project[4] }}</p>

    <h3>Members</h3>
    <p>{{ project[5] }}</p>

    <a href="/">Back to Projects</a>
</body>
</html>

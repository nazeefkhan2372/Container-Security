<?php
$servername = "db.cyber23.test";
$username = "wwwclient23";
$password = "wwwclient23Creds";
$dbname = "csvs23db";

// Create connection with error handling
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Prepare and execute the query
$stmt = $conn->prepare("SELECT fullname, suggestion FROM suggestion");
if (!$stmt) {
    die("Prepare failed: " . $conn->error);
}

$stmt->execute();
if (!$stmt->execute()) {
    die("Execution failed: " . $stmt->error);
}

$stmt->store_result();

// Build the HTML structure
$HTML = <<<THEEND
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="style.css">
<title>Staff Suggestions</title> 
</head>
<body>
  <div class="container"> 
    <h1>Staff Suggestions</h1> 
    <h3>Share your constructive ideas to improve our workplace!</h3> 

    <form action="action.php" method="post">
      <label for="fullname">Username:</label><br> 
      <input type="text" id="fullname" name="fullname" required><br> 
      <label for="suggestion">Suggestion:</label><br> 
      <textarea id="suggestion" name="suggestion" rows="5" required></textarea><br><br> 
      <button type="submit">Submit Suggestion</button> 
    </form> 

    <p>Submit your suggestions to help us create a better working environment.</p>

    <table style="border:1px solid black">
      <tr>
        <th>User</th>
        <th>Suggestion</th>
      </tr>
THEEND;

// Fetch results and dynamically create table rows
$stmt->bind_result($cuser, $csuggestion);
while ($stmt->fetch()) {
  $HTML .= "<tr>";
  $HTML .= "<td>" . $cuser . "</td>";
  $HTML .= "<td>" . $csuggestion . "</td>";
  $HTML .= "</tr>";
}

// Complete the HTML
$HTML .= <<<THEEND
    </table>  
  </div>
</body>
</html>
THEEND;

// Output the HTML
echo $HTML;

// Close resources
$stmt->close();
$conn->close();
?>

<?php
header('Content-Type: application/json');
$servername = "mysql.cs.okstate.edu"; // Change this as necessary
$username = "dchitte"; // Your database username
$password = "he@vyFact62"; // Your database password
$dbname = "dchitte"; // Your database name

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 

$sql = "SELECT name, nickname FROM states";
$result = $conn->query($sql);

$states = [];

if ($result->num_rows > 0) {
    // output data of each row
    while($row = $result->fetch_assoc()) {
        $states[] = $row;
    }
    echo json_encode($states);
} else {
    echo json_encode([]);
}

$conn->close();
?>

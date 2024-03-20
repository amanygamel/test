<?php
// Connect to MySQL database
$servername = "localhost";
$username = "mywebsite_user";
$password = "StrongPassword123!";
$database = "mywebsite_db";

$conn = new mysqli($servername, $username, $password, $database);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Get visitor's IP address
$ip_address = $_SERVER['REMOTE_ADDR'];

// Insert visitor information into database
$sql = "INSERT INTO visitor_logs (ip_address) VALUES ('$ip_address')";
$conn->query($sql);

// Display visitor's IP address and current time
echo "Hello visitor from " . $ip_address . "!<br>";
echo "The current time is: " . date("Y-m-d H:i:s");

// Close database connection
$conn->close();
?>



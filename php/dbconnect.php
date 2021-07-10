<?php
$servername = "localhost";
$username   = "javathre_bamboogroveAdmin";
$password   = "os5_U6CDm9nT";
$dbname     = "javathre_bamboogrovedb";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}else{

}
?>
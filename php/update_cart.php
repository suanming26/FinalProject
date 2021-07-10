<?php
error_reporting(0);
include_once("dbconnect.php");

$email = $_POST['email'];
$foodid = $_POST['foodid'];
$foodqty = $_POST['foodqty'];

$sqlupdate = "UPDATE tbl_cart SET foodqty = '$foodqty' WHERE email = '$email' AND foodid = '$foodid'";

if ($conn->query($sqlupdate) === true)
{
    echo "success";
}
else
{
    echo "failed";
}
    
$conn->close();
?>
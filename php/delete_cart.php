<?php
error_reporting(0);
include_once("dbconnect.php");

$foodid = $_POST['foodid'];
$email = $_POST['email'];

$sqldelete = "DELETE FROM tbl_cart WHERE email = '$email' AND foodid = '$foodid'";


if ($conn->query($sqldelete) === TRUE){
   echo "success";
}else {
    echo "failed";
}
?>
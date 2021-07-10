<?php
error_reporting(0);
include_once("dbconnect.php");
$foodid = $_POST['foodid'];

$sqldelete = "DELETE FROM tbl_product  WHERE foodid  = '$foodid'";
    if ($conn->query($sqldelete) === TRUE){
       echo "success";
    }else {
        echo "failed";
    }
?>
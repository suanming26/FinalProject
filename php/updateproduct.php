<?php

include_once("dbconnect.php");

$foodid  = $_POST['foodid'];
$foodname = $_POST['foodname'];
$foodprice = $_POST['foodprice'];
$foodcat = $_POST['foodcat'];

$sql = "SELECT * FROM tbl_product WHERE foodid = '$foodid'";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        $sqlupdate = "UPDATE tbl_product SET foodname = '$foodname', foodprice = '$foodprice', foodcat = '$foodcat' WHERE foodid = '$foodid'";
        if ($conn->query($sqlupdate) === TRUE){
                    echo 'success';
            }else{
                    echo 'failed';
            }
    }
    else{
        echo "failed";
    }
    
?>
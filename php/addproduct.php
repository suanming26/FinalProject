<?php

include_once("dbconnect.php");

$foodname = $_POST['foodname'];
$foodprice = $_POST['foodprice'];
$foodcat = $_POST['foodcat'];
$encoded_string = $_POST["encoded_string"];

$sqlinsert = "INSERT INTO tbl_product(foodname,foodprice,foodcat) VALUES('$foodname','$foodprice','$foodcat')";
if ($conn->query($sqlinsert) === TRUE){
    $decoded_string = base64_decode($encoded_string);
    $filename = mysqli_insert_id($con);
    $path = '../images/product/'.$filename.'.png';
    $is_written = file_put_contents($path, $decoded_string);
    echo "success";
}else{
    echo "failed";
}

?>
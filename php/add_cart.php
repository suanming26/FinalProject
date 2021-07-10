<?php
error_reporting(0);
include_once("dbconnect.php");

$foodid = $_POST['foodid'];
$email = $_POST['email'];
$foodqty = "1";


$sqlsearch = "SELECT * FROM tbl_cart WHERE email = '$email' AND foodid = '$foodid'";

$result = $conn->query($sqlsearch);
if ($result->num_rows > 0) {
    while ($row = $result ->fetch_assoc()){
        $prquantity = $row["foodqty"];
    }
    $prquantity = $prquantity + $foodqty;
    $sqlinsert = "UPDATE tbl_cart SET foodqty = '$prquantity' WHERE email = '$email' AND foodid = '$foodid' ";
    
}else{
    $sqlinsert = "INSERT INTO tbl_cart(email,foodid,foodqty) VALUES ('$email','$foodid','$foodqty')";
}

if ($conn->query($sqlinsert) === true)
{
   
    echo "success";
}
else
{
    echo "failed";
}


?>
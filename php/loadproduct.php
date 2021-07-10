<?php

include_once("dbconnect.php");

$foodname=$_POST['foodname'];

if (isset($foodname)){
   $sqlloadproducts= "SELECT * FROM tbl_product WHERE foodname LIKE  '%$foodname%'";
} else {
    $sqlloadproducts= "SELECT * FROM tbl_product ORDER BY foodid DESC";
}

$result = $conn->query($sqlloadproducts);

if ($result->num_rows > 0){
    $response["products"] = array();
    while ($row = $result -> fetch_assoc()){
        $productlist = array();
        $productlist[foodid] = $row['foodid'];
        $productlist[foodname] = $row['foodname'];
        $productlist[foodprice] = $row['foodprice'];
        $productlist[foodcat] = $row['foodcat'];
        array_push($response["products"],$productlist);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}

?>
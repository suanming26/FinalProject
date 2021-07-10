<?php
error_reporting(0);
include_once ("dbconnect.php");
$email = $_POST['email'];

if (isset($email)){
     $sql = "SELECT tbl_product.foodid, tbl_product.foodname, tbl_cart.foodqty, tbl_product.foodprice FROM tbl_product INNER JOIN tbl_cart ON tbl_cart.foodid = tbl_product.foodid WHERE tbl_cart.email = '$email'";
}


$result = $conn->query($sql);

if ($result->num_rows > 0)
{
    $response["cart"] = array();
    while ($row = $result->fetch_assoc())
    {
        $cartlist = array();
        $cartlist["foodid"] = $row["foodid"];
        $cartlist["foodname"] = $row["foodname"];
        $cartlist["foodprice"] = $row["foodprice"];
        $cartlist["foodqty"] = $row["foodqty"];
    
        $cartlist["total_price"] = round(doubleval($row["foodprice"])*(doubleval($row["foodqty"])),2)."";
        
        array_push($response["cart"], $cartlist);
    }
    echo json_encode($response);
}
else
{
    echo "Cart Empty";
}

?>
<?php
error_reporting(0);
include_once("dbconnect.php");

$email = $_GET['email']; //email
$name = $_GET['name']; 
$amount = $_GET['amount']; 
$dateTime = $_GET['dateTime']; 
$address = $_GET['address']; 
$status = $_GET['status'];

// echo $email;
// echo $name;
// echo $amount;
// echo $dateTime;
// echo $address;
// echo $status;

$data = array(
    'id' =>  $_GET['billplz']['id'],
    'paid_at' => $_GET['billplz']['paid_at'] ,
    'paid' => $_GET['billplz']['paid'],
    'x_signature' => $_GET['billplz']['x_signature']
);

$paidstatus = $_GET['billplz']['paid'];

if ($paidstatus=="true"){
  $receiptid = $_GET['billplz']['id'];
  $signing = '';
    foreach ($data as $key => $value) {
        $signing.= 'billplz'.$key . $value;
        if ($key === 'paid') {
            break;
        } else {
            $signing .= '|';
        }
    }
    
  $sqlinsertpurchased = "INSERT INTO tbl_payment(email,amount,address,dateTime,status) VALUES ('$email','$amount','$address','$dateTime','$status')";
  $sqldeletecart = "DELETE FROM tbl_cart WHERE email='$email'";
   
  $stmt = $conn->prepare($sqlinsertpurchased);
  $stmt->execute();
  $stmtdel = $conn->prepare($sqldeletecart);
  $stmtdel->execute();
   
   
      echo '<br><br><body><div><h2><br><br><center>Your Receipt</center>
     </h1>
     <table border=1 width=80% align=center>
     <tr><td>Receipt ID</td><td>'.$receiptid.'</td></tr><tr><td>Email to </td>
     <td>'.$email. ' </td></tr><td>Amount </td><td>RM '.$amount.'</td></tr>
     <tr><td>Payment Status </td><td>'.$paidstatus.'</td></tr>
     <tr><td>Status </td><td>'.$status.'</td></tr>
     <tr><td>Address </td><td>'.$address.'</td></tr>
     <tr><td>Date </td><td>'.date("d/m/Y").'</td></tr>
     <tr><td>Time </td><td>'.date("h:i a").'</td></tr>
     </table><br>
     <p><center>Press back button to return to your app</center></p></div></body>';
    
}
else{
     echo 'Payment Failed!';
}
?>
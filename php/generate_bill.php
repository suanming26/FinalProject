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

$api_key = 'c93a3751-5772-4096-8cdb-7dcc192d1b18';
$collection_id = 'hnyekecu';
$host = 'https://billplz-staging.herokuapp.com/api/v3/bills';

$data = array(
    'collection_id' => $collection_id,
    'email' => $email,
    'name' => $name,
    'amount' => $amount * 100, // RM20
    'description' => 'Payment for order' ,
    'callback_url' => "https://javathree99.com/s271490/bamboogrove/php/return_url",
    'redirect_url' => "https://javathree99.com/s271490/bamboogrove/php/update_payment.php?email=$email&name=$name&status=$status&amount=$amount&dateTime=$dateTime&address=$address" 
);


$process = curl_init($host );
curl_setopt($process, CURLOPT_HEADER, 0);
curl_setopt($process, CURLOPT_USERPWD, $api_key . ":");
curl_setopt($process, CURLOPT_TIMEOUT, 30);
curl_setopt($process, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($process, CURLOPT_SSL_VERIFYHOST, 0);
curl_setopt($process, CURLOPT_SSL_VERIFYPEER, 0);
curl_setopt($process, CURLOPT_POSTFIELDS, http_build_query($data) ); 

$return = curl_exec($process);
curl_close($process);

$bill = json_decode($return, true);

echo "<pre>".print_r($bill, true)."</pre>";
header("Location: {$bill['url']}");
?>
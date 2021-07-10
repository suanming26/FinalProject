<?php
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require '/home8/javathre/public_html/s271490/bamboogrove/php/PHPMailer/Exception.php';
require '/home8/javathre/public_html/s271490/bamboogrove/php/PHPMailer/PHPMailer.php';
require '/home8/javathre/public_html/s271490/bamboogrove/php/PHPMailer/SMTP.php';

include_once("dbconnect.php");

$username = $_POST['username'];
$user_email = $_POST['email'];
$password = $_POST['password'];
$passha1 = sha1($password);
$otp = rand(1000,9999);
$rating = "0";
$credit = "0";
$status = "active";

$sqlregister = "INSERT INTO tbl_user(username,user_email,password,otp,rating,credit,status) VALUES('$username','$user_email','$passha1','$otp','$rating','$credit','$status')";
if ($conn->query($sqlregister) === TRUE){
    echo "success";
    sendEmail($otp,$user_email);
}else{
    echo "failed";
}
function sendEmail($otp,$user_email){
    $mail = new PHPMailer(true);
    $mail->SMTPDebug = 0;                           //Disable verbose debug output
    $mail->isSMTP();                                //Send using SMTP
    $mail->Host       = 'mail.javathree99.com';                         //Set the SMTP server to send through
    $mail->SMTPAuth   = true;                       //Enable SMTP authentication
    $mail->Username   = 'bamboogrove@javathree99.com';                         //SMTP username
    $mail->Password   = 'bamboogrove123';                         //SMTP password
    $mail->SMTPSecure = 'tls';         
    $mail->Port       = 587;
    
    $from = "bamboogrove@javathree99.com";
    $to = $user_email;
    $subject = "Account Verification form Bamboo Grove";
    $message = "<p>Hi!<br><br>Welcome to Bamboo Grove！Your account is successfully created!<a href='https://javathree99.com/s271490/bamboogrove/php/verify_account.php?email=".$user_email."&key=".$otp."'>Click Here</a> to verify your account";
    $header = "From:".$from;
    mail($user_email,$subject,$message,$header);
  
    $mail->setFrom($from,"BambooGrove");
    $mail->addAddress($to);                                             //Add a recipient
    
    //Content
    $mail->isHTML(true);                                                //Set email format to HTML
    $mail->Subject = $subject;
    $mail->Body    = $message;
    $mail->send();
}
?>
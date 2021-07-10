<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require '/home8/javathre/public_html/s269426/constructorequipment/php/PHPMailer/Exception.php';
require '/home8/javathre/public_html/s269426/constructorequipment/php/PHPMailer/PHPMailer.php';
require '/home8/javathre/public_html/s269426/constructorequipment/php/PHPMailer/SMTP.php';

include_once("dbconnect.php");

$user_email = $_POST['email'];
$newotp = rand(1000,9999);
$newpassword = random_password(10);
$passha = sha1($newpassword);

$sql = "SELECT * FROM tbl_user WHERE user_email = '$user_email'";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        $sqlupdate = "UPDATE tbl_user SET otp = '$newotp', password = '$passha' WHERE user_email = '$user_email'";
        if ($conn->query($sqlupdate) === TRUE){
                sendEmail($newotp,$newpassword,$user_email);
                echo 'success';
        }else{
                echo 'failed';
        }
    }else{
        echo "failed";
    }

function sendEmail($otp,$newpassword,$user_email){
    $mail = new PHPMailer(true);
    $mail->SMTPDebug = 0;                                               //Disable verbose debug output
    $mail->isSMTP();                                                    //Send using SMTP
    $mail->Host       = 'mail.javathree99.com';                         //Set the SMTP server to send through
    $mail->SMTPAuth   = true;                                           //Enable SMTP authentication
    $mail->Username   = 'bamboogrove@javathree99.com';                    //SMTP username
    $mail->Password   = 'bamboogrove123';                                 //SMTP password
    $mail->SMTPSecure = 'tls';         
    $mail->Port       = 587;
    
    $from = "bamboogrove@javathree99.com";
    $to = $user_email;
    $subject = "Reset Password from Bamboo Grove";
    $message = "<p>Hi!<br><br>Your account password has been reset.<br>
    <a href='https://javathree99.com/s271490/bamboogrove/php/verify_account.php?email=".$user_email."&key=".$otp."'>Click Here to reactivate your account</a>
    <br><br>Please use the password below to login.</p><br><br><h3>Password:".$newpassword."</h3>";
    
    $mail->setFrom($from,"BambooGrove");
    $mail->addAddress($to);                                             //Add a recipient
    
    //Content
    $mail->isHTML(true);                                                //Set email format to HTML
    $mail->Subject = $subject;
    $mail->Body    = $message;
    $mail->send();
}

function random_password($length){
    //A list of characters that can be used in our random password
    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    //Create blank string
    $password = '';
    //Get the index of the last character in our $characters string
    $characterListLength = mb_strlen($characters, '8bit') - 1;
    //Loop from 1 to the length that was specified
    foreach(range(1,$length) as $i){
        $password .=$characters[rand(0,$characterListLength)];
    }
    return $password;
}
?>
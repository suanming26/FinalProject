import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bamboogrove/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Registerscreen extends StatefulWidget {
  @override
  _RegisterscreenState createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {

  TextEditingController nameC = new TextEditingController();
  TextEditingController emailC = new TextEditingController();
  TextEditingController passwordC = new TextEditingController();
  TextEditingController confirmPasswordC = new TextEditingController();
  SharedPreferences prefs;
  bool _showpassword = false;
  bool _showpassword1 = false;
  bool _termsCondition = false;

 

  @override
  Widget build(BuildContext context) {
    
        return MaterialApp(
          home: Scaffold(
            appBar:AppBar(
              title:Text('BAMBOO GROVE RESTAURANT'), 
              backgroundColor:Colors.cyan.shade700,
            ),
            body:Center(
              child:Container(
                constraints:BoxConstraints.expand(),
                decoration: BoxDecoration(image:DecorationImage(
                  image:AssetImage('assets/images/background.jpg'), 
                fit:BoxFit.cover,
                colorFilter:new ColorFilter.mode(Colors.black.withOpacity(0.5),BlendMode.dstATop)),
                ),
          child: Center(
            child: SingleChildScrollView(
          child:Column(
            children:[
              Container(margin:EdgeInsets.fromLTRB(55,0,55,0),
              child:
              Image.asset('assets/images/profile.png',scale:1.9)),
              
            Card(
              margin:EdgeInsets.fromLTRB(20,0,20,0),
              elevation: 0,
              color:Colors.transparent,
              child:Padding(
                padding:const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child:Column(
                children: [
                  Text('REGISTRATION FORM', 
                  style:TextStyle(fontSize:20,
                  color:Colors.cyan[900])),
                  TextField(controller:nameC,
                    decoration:InputDecoration(labelText:'Username',
                    labelStyle:TextStyle(fontSize:15,color:Colors.black),
                    icon:Icon(Icons.account_circle)
                  )
                  ),
                  TextField(controller:emailC,
                    keyboardType:TextInputType.emailAddress,
                    decoration:InputDecoration(labelText:'Email Address',
                    labelStyle:TextStyle(fontSize:15,color:Colors.black),
                    icon:Icon(Icons.email)
                  )
                  ),
                  TextField(controller:passwordC,
                    decoration:InputDecoration(labelText:'Password',
                    labelStyle:TextStyle(fontSize:15,color:Colors.black),
                    icon:Icon(Icons.lock),
                    suffixIcon: GestureDetector(onTap:(){
                      setState(() {
                        _showpassword = !_showpassword;
                      });
                    },child:
                    Icon(_showpassword?Icons.visibility:Icons.visibility_off,),
                    )
                    ),
                    obscureText: !_showpassword,
                  ),
                  TextField(controller:confirmPasswordC,
                    decoration:InputDecoration(labelText:'Confirm Password',
                    labelStyle:TextStyle(fontSize:15,color:Colors.black),
                    icon:Icon(Icons.lock),
                    suffixIcon: GestureDetector(onTap:(){
                      setState(() {
                        _showpassword1 = !_showpassword1;
                      });
                    },child:
                    Icon(_showpassword1 ?Icons.visibility:Icons.visibility_off,),
                    )
                    ),
                    obscureText: !_showpassword1,
                  ),
                  Row(
                    children: [
                      Checkbox(value:_termsCondition,
                      onChanged:
                      (bool value){_onChanged(value);}),
                      Text("I accept all the ",
                      style:TextStyle(
                        color:Colors.black,
                        fontSize:15)),
                  GestureDetector(
                  child:
                  Text('Terms and Conditions',
                  style:
                  TextStyle(
                    color:Colors.cyan[900],
                    decoration:TextDecoration.underline,
                    fontWeight:FontWeight.bold,
                    fontSize:15),
                    ),)
                    ]),
              ], ))),

               MaterialButton(shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),),
                minWidth:150,
                height:50,
                child:Text('Register',style: TextStyle(fontSize:20,color:Colors.white),),
                onPressed:_onRegister,
                color:Colors.blueGrey[400],
               ),
                SizedBox(height:10),
                Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children:[
                    Text('Already register?  ',
                    style:TextStyle(
                      color:Colors.black,fontSize:15)), 
                    ]),
                GestureDetector(
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Text('Login Now',
                      style:TextStyle(
                        color:Colors.cyan[900],
                        decoration:TextDecoration.underline,
                        fontWeight:FontWeight.bold,
                        fontSize:15),),
                        
                    ]),   
                   onTap:_login,
                   ),                   
                ], 
           )
         )
       )
     )
     ))
     );
    }                             

     void _onRegister() {
       String _username = nameC.text.toString();
       String _email = emailC.text.toString();
       String _password = passwordC.text.toString();
       String _confirmPassword = confirmPasswordC.text.toString();

         if(_username.isEmpty && _email.isEmpty &&
        _password.isEmpty && _confirmPassword.isEmpty && _termsCondition == false){
          Fluttertoast.showToast(
             msg: "Username/Email/Password/Confirm Password/Terms and Condition is empty!", 
             toastLength:Toast.LENGTH_SHORT,
             gravity:ToastGravity.CENTER,
             timeInSecForIosWeb: 1,
             backgroundColor:Colors.blueGrey[400],
             textColor: Colors.white,
             fontSize:16);
       return ;
       }else if(_username.isEmpty){
          Fluttertoast.showToast(
             msg: "Username is empty!", 
             toastLength:Toast.LENGTH_SHORT,
             gravity:ToastGravity.CENTER,
             timeInSecForIosWeb: 1,
             backgroundColor:Colors.blueGrey[400],
             textColor: Colors.white,
             fontSize:16);
       return ;
       }else if( _email.isEmpty ){
          Fluttertoast.showToast(
             msg: "Email is empty!", 
             toastLength:Toast.LENGTH_SHORT,
             gravity:ToastGravity.CENTER,
             timeInSecForIosWeb: 1,
             backgroundColor:Colors.blueGrey[400],
             textColor: Colors.white,
             fontSize:16);
       return ;
       }else if( _email.contains(RegExp(r'[@]'))== false ){
          Fluttertoast.showToast(
             msg: "Email is invalid!", 
             toastLength:Toast.LENGTH_SHORT,
             gravity:ToastGravity.CENTER,
             timeInSecForIosWeb: 1,
             backgroundColor:Colors.blueGrey[400],
             textColor: Colors.white,
             fontSize:16);
       return ;
       }else if( _password.isEmpty){
          Fluttertoast.showToast(
             msg: "Password is empty!", 
             toastLength:Toast.LENGTH_SHORT,
             gravity:ToastGravity.CENTER,
             timeInSecForIosWeb: 1,
             backgroundColor:Colors.blueGrey[400],
             textColor: Colors.white,
             fontSize:16);
       return ;
       }else if(_confirmPassword.isEmpty){
          Fluttertoast.showToast(
             msg: "Confirm Password is empty!", 
             toastLength:Toast.LENGTH_SHORT,
             gravity:ToastGravity.CENTER,
             timeInSecForIosWeb: 1,
             backgroundColor:Colors.blueGrey[400],
             textColor: Colors.white,
             fontSize:16);
       return ;
       }else if(_termsCondition == false){
          Fluttertoast.showToast(
             msg: "Please read the terms and conditions!", 
             toastLength:Toast.LENGTH_SHORT,
             gravity:ToastGravity.CENTER,
             timeInSecForIosWeb: 1,
             backgroundColor:Colors.blueGrey[400],
             textColor: Colors.white,
             fontSize:16);
       return ;
       }else if(_password != _confirmPassword || _confirmPassword != _password){
         Fluttertoast.showToast(
             msg: "Please make sure your password is MATCH.", 
             toastLength:Toast.LENGTH_SHORT,
             gravity:ToastGravity.CENTER,
             timeInSecForIosWeb: 1,
             backgroundColor:Colors.blueGrey[400],
             textColor: Colors.white,
             fontSize:16);
             return;
       }
       showDialog(
         context: context,
         builder:(BuildContext context){
           return AlertDialog(
             shape:RoundedRectangleBorder(
               borderRadius: BorderRadius.all(Radius.circular(10.0))),
             title: Text("Register New User"),
             content: Text("Are you sure?"),
             actions:[
               TextButton(
                 child:Text("OK"), 
                 onPressed:(){
                   Navigator.of(context).pop();
                   _registerUser(_username,_email,_password); 
                 }
               ),
               TextButton(
                 child:Text("CANCEL"),
                  onPressed:(){
                 Navigator.of(context).pop();
               }) ,
             ]
           );
         }
       );         
  }

  void _login() {
    Navigator.push
      (context,MaterialPageRoute(builder:
      (content)=>Loginscreen())
     );
  }

  void _registerUser(String username,String email, String password) {
    http.post (
      Uri.parse("https://javathree99.com/s271490/bamboogrove/php/register_user.php"),
      body:{
        "username":username,
        "email":email,
        "password":password
      }).then((response){
        print(response.body);
        if(response.body=="success"){
          Fluttertoast.showToast(
            msg: "Registration Success. Please check your email for verification link.",
            toastLength:Toast.LENGTH_SHORT,
            gravity:ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor:Colors.blueGrey[400],
            textColor: Colors.white,
             fontSize:16);
        }else{
          Fluttertoast.showToast(
            msg: "Registration Failed.",
            toastLength:Toast.LENGTH_SHORT,
            gravity:ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor:Colors.blueGrey[400],
            textColor: Colors.white,
             fontSize:16);
        }
      });
  }
  void _onChanged(bool value) {
    String _username = nameC.text.toString();
    String _password = passwordC.text.toString();
    String _email = emailC.text.toString();
    String _confirmPassword = confirmPasswordC.text.toString();

    if(_email.isEmpty || _password.isEmpty || 
    _confirmPassword.isEmpty || _username.isEmpty){
                 Fluttertoast.showToast(
                   msg: "Please make sure your information is filled.", 
                   toastLength:Toast.LENGTH_SHORT,
                   gravity:ToastGravity.CENTER,
                   timeInSecForIosWeb: 1,
                   backgroundColor:Colors.blueGrey[400],
                   textColor: Colors.white,
                   fontSize:16);
                 return ;
               }
               setState(() {
                 _termsCondition = value;
               });
  }
   
}
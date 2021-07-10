import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bamboogrove/main_screen.dart';
import 'package:bamboogrove/register_screen.dart';
import 'package:bamboogrove/userinfo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Loginscreen extends StatefulWidget {
  @override
  _LoginscreenState createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  bool _rememberMe= false;

  TextEditingController emailC = new TextEditingController();
  TextEditingController passwordC = new TextEditingController();
  TextEditingController recoveryEmailC = new TextEditingController();
  SharedPreferences prefs;
  bool _showpassword = false;

  @override
  void initState() {
    loadPref();
    super.initState();
  }

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
            child:Center(
              child: SingleChildScrollView(
          child:Column(
            children:[
              Container(margin:EdgeInsets.fromLTRB(70,0,90,0),
              child:
              Image.asset('assets/images/logo1.png',scale:1.5)),
              
            Card(
              margin:EdgeInsets.fromLTRB(6,0,10,6),
              elevation: 0,
              color:Colors.transparent,
              // shape:RoundedRectangleBorder(
              // side: BorderSide(color: Colors.blueGrey,width:2),
              // borderRadius: BorderRadius.circular(20),
              // ),
              child:Padding(
                padding:const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child:Column(
                children: [
                  Container(
                    alignment:Alignment.topLeft,
                  child:Text('HELLO', 
                  style:TextStyle(fontSize:50,
                  color:Colors.cyan[900])),
                  ),
                  Container(
                    alignment:Alignment.topLeft,
                    child:Text('Sign in to your account', 
                  style:TextStyle(fontSize:15,
                  color:Colors.cyan[900])),
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
                    ),
                    obscureText: !_showpassword,
                  ),
                  Row(
                    children: [
                      Checkbox(value:_rememberMe,
                      onChanged:
                      (bool value){_onChanged(value);}),
                      Text("Remember Me         ",
                      style:TextStyle(
                        color:Colors.black,
                        fontSize:15)),
                 GestureDetector(
                  child:
                  Text('Forgot Password?',
                  style:
                  TextStyle(
                    color:Colors.cyan[900],
                    decoration:TextDecoration.underline,
                    fontWeight:FontWeight.bold,
                    fontSize:15),
                    ),
                    onTap:_forgotPassword,
               ),                    
                    ],
                    
                  )
              ],
              )
              )
              ),
               MaterialButton(shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),),
                minWidth:150,
                height:50,
                child:Text('Login',style: TextStyle(fontSize:20,color:Colors.white),),
                onPressed:_onLogin,
                color:Colors.blueGrey[400],
                ),
                SizedBox(height:15),
                    GestureDetector(
                      child:Row(   
                   mainAxisAlignment: MainAxisAlignment.center,
                   children:<Widget>[
                  Text("Don't have account?  ",
                  style:
                  TextStyle(color:Colors.black,fontSize:15)
                  ),
                  Text('Register Now',
                  style:
                  TextStyle(
                    color:Colors.cyan[900],
                    decoration:TextDecoration.underline,
                    fontWeight:FontWeight.bold,
                    fontSize:15)),
                    ],),
                    onTap: _registerNow,
               ),
               SizedBox(height:5),
               
            ], 
           ))
          )
         )
        )));
      }                             
   void _onLogin() {
     String _email = emailC.text.toString();
     String _password = passwordC.text.toString();

     http.post (
      Uri.parse("https://javathree99.com/s271490/bamboogrove/php/login_user.php"),
      body:{
        "email":_email,
        "password":_password
      }).then((response){
        print(response.body);
        if(response.body=="failed"){
          Fluttertoast.showToast(
            msg: "Login Failed.Please try again!",
            toastLength:Toast.LENGTH_SHORT,
            gravity:ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor:Colors.blueGrey[400],
            textColor: Colors.white,
             fontSize:16);
        }else{
          List userinfo = response.body.split(",");
          Userinfo _userinfo = Userinfo(
            email:_email,
            password:_password,
            username:userinfo[1],
            date:userinfo[2],
            rating:userinfo[3],
            credit:userinfo[4],
            status:userinfo[5],
            );
              Navigator.pushReplacement
            (context,MaterialPageRoute(builder:
            (content)=>Mainscreen(userinfo: _userinfo)));
        }
      });
    }
           void _registerNow() {
             Navigator.push
                  (context,MaterialPageRoute(builder:
                  (content)=>Registerscreen())
                  );
           }
          
          _onChanged(bool value) {
               String _email = emailC.text.toString();
               String _password = passwordC.text.toString();

               if(_email.isEmpty || _password.isEmpty){
                 Fluttertoast.showToast(
                   msg: "Email/Password is empty!", 
                   toastLength:Toast.LENGTH_SHORT,
                   gravity:ToastGravity.CENTER,
                   timeInSecForIosWeb: 1,
                   backgroundColor:Colors.blueGrey[400],
                   textColor: Colors.white,
                   fontSize:16);

                 return ;
               }
                setState(() {
                  _rememberMe = value;
                  savePrefs(value,_email,_password);
                });
         }
                  
            Future<void> savePrefs(bool value, String email, String password) async {
              prefs = await SharedPreferences.getInstance();
              if(value){
                await prefs.setString("email", email);
                await prefs.setString("password", password);
                await prefs.setBool("rememberme", value);
                Fluttertoast.showToast(
                   msg: "Preferences stored.", 
                   toastLength:Toast.LENGTH_SHORT,
                   gravity:ToastGravity.CENTER,
                   timeInSecForIosWeb: 1,
                   backgroundColor:Colors.blueGrey[400],
                   textColor: Colors.white,
                   fontSize:16);
                   return;
              }else{
                await prefs.setString("email", '');
                await prefs.setString("password", '');
                await prefs.setBool("rememberme", false);
                Fluttertoast.showToast(
                   msg: "Preferences removed.", 
                   toastLength:Toast.LENGTH_SHORT,
                   gravity:ToastGravity.CENTER,
                   timeInSecForIosWeb: 1,
                   backgroundColor:Colors.blueGrey[400],
                   textColor: Colors.white,
                   fontSize:16);
                setState(() {
                     emailC.text = "";
                     passwordC.text = "";
                     _rememberMe = false;
              });
               return;

              }
            }

            Future<void> loadPref() async {
              prefs = await SharedPreferences.getInstance();
              String _email = prefs.getString("email")??'';
              String _password = prefs.getString("password")??'';
              _rememberMe = prefs.getBool("rememberme")?? false;

              setState(() {
                emailC.text = _email;
                passwordC.text = _password;
                
              });

            }
            void _forgotPassword() {

            showDialog(
              context: context,
             builder: (BuildContext context){
               return AlertDialog(
                 title:Text("Forgot Your Password?",
                 style:TextStyle(
                   fontSize:20,
                   color:Colors.cyan[900],
                   fontStyle:FontStyle.italic),),
                 content: new Container(
                   height:80,
                   child: Column(
                     children: [
                       Text("Enter your recovery email address:"),
                       TextField(controller:recoveryEmailC,
                         decoration:InputDecoration(labelText:'Email Address',
                         labelStyle:TextStyle(fontSize:15,color:Colors.black),
                         icon:Icon(Icons.email)),
                       )
                   ],),
                   ),
                 actions: [
                   TextButton(
                     style: TextButton.styleFrom(
                    primary: Colors.white, backgroundColor: Colors.blueGrey[400]),
                     child:Text("Submit"),
                     onPressed: (){
                       print(recoveryEmailC.text);
                       resetPassword(recoveryEmailC.text.toString());
                       Navigator.of(context).pop();
                   }),
                   TextButton(
                     style: TextButton.styleFrom(
                    primary: Colors.white, backgroundColor: Colors.red[200]),
                     child:Text("Cancel"),onPressed: (){
                     Navigator.of(context).pop();
                   })
                 ],  
               );
             });
          }

  void resetPassword(String resetEmail) {
    http.post (
      Uri.parse("https://javathree99.com/s271490/bamboogrove/php/forgot_password.php"),
      body:{
        "email":resetEmail,
      }).then((response){
        print(response.body);
        if(response.body=="success"){
          Fluttertoast.showToast(
            msg: "Reset Password Complete.Please check your email.",
            toastLength:Toast.LENGTH_SHORT,
            gravity:ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor:Colors.blueGrey[400],
            textColor: Colors.white,
             fontSize:16);
        }else{
          Fluttertoast.showToast(
            msg: "Reset Password Failed. Please try again.",
            toastLength:Toast.LENGTH_SHORT,
            gravity:ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor:Colors.blueGrey[400],
            textColor: Colors.white,
             fontSize:16);
        }
      });
  }
}
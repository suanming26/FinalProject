
import 'package:bamboogrove/userinfo.dart';
import 'package:flutter/material.dart';

class Myprofile extends StatefulWidget {
  final Userinfo userinfo;

  const Myprofile({ key, this.userinfo }) : super(key: key);

  @override
  _MyprofileState createState() => _MyprofileState();
}

class _MyprofileState extends State<Myprofile> {
  double screenHeight, screenWidth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
                  appBar: AppBar(
                      title: Text('My Profile'),
                      backgroundColor: Colors.cyan.shade700,
                    ),
                    body: Center(
                      child: Container(
                        constraints:BoxConstraints.expand(),
                        decoration: BoxDecoration(image:DecorationImage(
                        image:AssetImage('assets/images/background2.jpg'), 
                        fit:BoxFit.cover,
                         colorFilter:new ColorFilter.mode(Colors.black.withOpacity(0.5),BlendMode.dstATop)),
                         ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                             Container(margin:EdgeInsets.fromLTRB(55,0,55,0),
                              child:
                                Image.asset('assets/images/profile.png',scale:1.4)),
                              SizedBox(height: 10),
                              Container(
                                 margin:EdgeInsets.fromLTRB(20,0,20,0),
                                  decoration: BoxDecoration(color: Colors.cyan.shade200),
                                child:Column(
                                  children: [
                                     ListTile( 
                                leading: Icon(Icons.account_circle),
                                title:Text(
                                  widget.userinfo.username,
                                  style:TextStyle(fontSize:20,
                                  fontWeight: FontWeight.bold)),
                                  subtitle: Text("Username",
                                  style:TextStyle(fontSize:15,
                                  fontWeight: FontWeight.bold)),
                                  ),
                             Padding(
                               padding:const EdgeInsets.fromLTRB(15, 0, 20, 0),
                               child:Divider(
                                 color:Colors.black,
                               ),
                             ),
                             ListTile( 
                                leading: Icon(Icons.email),
                                title:Text(
                                  widget.userinfo.email,
                                  style:TextStyle(fontSize:20,
                                  fontWeight: FontWeight.bold)),
                                  subtitle: Text("Email",
                                  style:TextStyle(fontSize:15,
                                  fontWeight: FontWeight.bold)),
                                  ),
                             Padding(
                               padding:const EdgeInsets.fromLTRB(15, 0, 20, 0),
                               child:Divider(
                                 color:Colors.black,
                               ),
                             ),
                             ListTile( 
                                leading: Icon(Icons.date_range),
                                title:Text(
                                  widget.userinfo.date,
                                  style:TextStyle(fontSize:20,
                                  fontWeight: FontWeight.bold)),
                                  subtitle: Text("Registered Date",
                                  style:TextStyle(fontSize:15,
                                  fontWeight: FontWeight.bold)),
                                  ),
                             Padding(
                               padding:const EdgeInsets.fromLTRB(15, 0, 20, 0),
                               child:Divider(
                                 color:Colors.black,
                               ),
                             ),
                              ListTile( 
                                leading: Icon(Icons.phone),
                                title:Text(
                                  widget.userinfo.status,
                                  style:TextStyle(fontSize:20,
                                  fontWeight: FontWeight.bold)),
                                  subtitle: Text("Status",
                                  style:TextStyle(fontSize:15,
                                  fontWeight: FontWeight.bold)),
                                  ),
                             Padding(
                               padding:const EdgeInsets.fromLTRB(15, 0, 20, 0),
                               child:Divider(
                                 color:Colors.black,
                               ),
                             ),
                   ],
                  )
                ),
                          
                ],),
              ),
                      ),
                    ),
             
          );
    }
  
}
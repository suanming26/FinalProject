import 'dart:async';
import 'package:bamboogrove/login_screen.dart';
import 'package:flutter/material.dart';


class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState(){
    super.initState();
    Timer(
      Duration(seconds: 2),
    ()=>Navigator.pushReplacement
    (context,MaterialPageRoute(builder:(content)=>Loginscreen()
    )
    )
    );

  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Column(
         mainAxisAlignment:MainAxisAlignment.center,
         children: [Container(margin:EdgeInsets.all(20),
         child:
           Image.asset('assets/images/logo.png',scale:0.5))
         ],

      ),
      
    );
  }
}
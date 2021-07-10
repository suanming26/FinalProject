import 'splashscreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BAMOBOO GROVE',
     darkTheme:ThemeData.dark(),
      home: Splashscreen(),
    );
  }
}
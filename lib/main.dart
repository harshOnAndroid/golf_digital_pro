import 'package:flutter/material.dart';
import 'package:golf_digital_pro/src/LandingPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: "TurretRoad",

      ),
      home: LandingPage(),
    );
  }
}



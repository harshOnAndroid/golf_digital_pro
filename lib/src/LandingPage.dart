import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:golf_digital_pro/src/MapsScreen.dart';
import 'package:golf_digital_pro/src/SearchScreen.dart';

class LandingPage extends StatefulWidget {

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          MapsScreen(),
          Positioned(
            bottom: 0,
              child: SearchScreen())
        ],
      ),
    );
  }
}
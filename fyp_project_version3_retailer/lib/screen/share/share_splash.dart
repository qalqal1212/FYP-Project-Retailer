import 'package:flutter/material.dart';
import 'package:fyp_project_version3_retailer/core/myroute.dart';

class ScreenSplash extends StatefulWidget {
  @override
  _ScreenSplashState createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() { 
    super.initState();
    Future.delayed(Duration(seconds: 3),
        () => Navigator.pushNamed(context, routeGotoSignin));
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.orange),
          Center(
              child: Container(
                width: 250,
                child: Image.asset('assets/image_01.png'),
              ),
          )
      ],
    );
  }
}
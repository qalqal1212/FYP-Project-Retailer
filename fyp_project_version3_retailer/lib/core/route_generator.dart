import 'package:flutter/material.dart';
import 'package:fyp_project_version3_retailer/screen/auth/signin.dart';
import 'package:fyp_project_version3_retailer/screen/auth/signup.dart';
import 'package:fyp_project_version3_retailer/screen/homepage.dart';
import 'package:fyp_project_version3_retailer/core/myroute.dart';
import 'package:fyp_project_version3_retailer/screen/payment.dart';




Route<dynamic> routeGenerator(RouteSettings settings) {
  switch (settings.name) {
    case routeGotoSignin:
    return MaterialPageRoute(builder: (context) => Signin());

    case routeGotoHomepage:
    return MaterialPageRoute(builder: (context) => HomePage());

    case routeGotoSignup:
    return MaterialPageRoute(builder: (context) => Signup());

    case routeGotoPayment:
    return MaterialPageRoute (builder:  (context) => Payment());

    default:
    return MaterialPageRoute(builder: (context) => HomePage());
  }
}
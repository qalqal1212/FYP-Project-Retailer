import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:fyp_project_version3_retailer/screen/share/share_loading.dart';
import 'package:http/http.dart' as HTTP;
import 'package:provider/provider.dart';
import 'package:fyp_project_version3_retailer/bloc/main_bloc.dart';
import 'package:fyp_project_version3_retailer/core/myroute.dart';
import 'package:fyp_project_version3_retailer/screen/screen.dart';
import 'package:flutter/material.dart';

 

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
    //variable to hold data textfield
  String dataEmail;
  String dataPassword;

  //! Variable >>> Form >>> Key
  final formKey = GlobalKey<FormState>();

  //! Service >>> Show / Hide Password
  bool _obsecureText = true;
  passwordShowHide() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }

  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: Colors.black)),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              )
            : Container(),
      );

  @override
  Widget build(BuildContext context) {
    final MainBloc mainBloc = Provider.of<MainBloc>(context);
    return Scaffold(
      backgroundColor: Colors.orange,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Image.asset("assets/image_01.png",
                    height: 180.0, width: 180.0),
              ),
              Expanded(child: Container()),
              Image.asset("assets/image_02.png")
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        "MRSM E-WALLET",
                        style: TextStyle(
                          fontFamily: "Poppins-Bold",
                          fontSize: 20,
                          letterSpacing: .6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                   Row(
                    children: <Widget>[
                      Text(
                        "Retailer Account",
                        style: TextStyle(
                          fontFamily: "Poppins-Bold",
                          fontSize: 20,
                          letterSpacing: .6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 75,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Email cannot be empty!";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (e) => dataEmail = e,
                          style: TextStyle(color: Colors.black, fontSize: 18),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            hintText: "Email Address",
                            hintStyle: TextStyle(
                                fontFamily: "Poppins-Bold",
                                fontSize: 18.0,
                                letterSpacing: .6),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Password must not be empty!";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (e) => dataPassword = e,
                          obscureText: _obsecureText,
                          style: TextStyle(color: Colors.black, fontSize: 18),
                          decoration: InputDecoration(
                            prefixIcon: IconButton(
                              onPressed: passwordShowHide,
                              icon: Icon(_obsecureText
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(
                                fontFamily: "Poppins-Bold",
                                fontSize: 18.0,
                                letterSpacing: .6),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "Forgot Password ?",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins-Medium",
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: double.infinity,
                          child: RaisedButton(
                            onPressed: () async {
                              final form = formKey.currentState;
                              if (form.validate()) {
                                form.save();
                                print("$dataEmail, $dataPassword");
                                String url =
                                    "http://10.0.2.2/fyp_project_api_version_1.0/api/retailer/retailersignin.php?" +
                                        "email=" +
                                        dataEmail +
                                        "&password=" +
                                        dataPassword;

                                final response = await HTTP.post(url);

                                final data = json.decode(response.body);

                                print(data);

                                if (data['status'] == true) {
                                  mainBloc.setretailerid(data['retailerid'].toString());
                                  Navigator.pushNamed(
                                      context, routeGotoHomepage);
                                } else {
                                  Navigator.pushNamed(context, routeGotoSignin);
                                }
                              }
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontFamily: "Poppins-Medium", fontSize: 28),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, routeGotoSignup);
                      },
                      child: Text(
                        "New User ? SignUp",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins-Bold",
                            fontSize: 18.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget builLoading() {
    return ScreenLoading();
  }
}
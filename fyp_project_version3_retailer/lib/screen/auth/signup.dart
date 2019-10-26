import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as HTTP;
import 'package:provider/provider.dart';
import 'package:fyp_project_version3_retailer/bloc/main_bloc.dart';
import 'package:fyp_project_version3_retailer/core/myroute.dart';

 
class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
//variable >> Textfield 
String dataEmail;
String dataPassword;

//Variable >>> Form >>> Key 
final formKey = GlobalKey<FormState>();

//Service >>> Show/Hide Password 

bool _obsecureText = true;
passwordShowHide() {
  setState(() {
  _obsecureText = !_obsecureText; 
  });
}
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
                height: 180.0,
                width: 180.0,),
              ),
              Expanded(
                child: Container(),
              ),
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
                           fontSize: 25,
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
                          onSaved: (value) => dataEmail = value,
                          style: TextStyle(color: Colors.black, fontSize: 18),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email), hintText: "Email Address", hintStyle: TextStyle(
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
                          onSaved: (value) => dataPassword = value,
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
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          child: RaisedButton(
                            onPressed: () async {
                                final form = formKey.currentState;
                                if (form.validate()) {
                                  form.save();
                                  print("$dataEmail, $dataPassword");
                                  String url = "http://10.0.2.2/fyp_project_api_version_1.0/api/retailer/retailersignup.php?student/studentsignup.php?" +
                                  "email=" +
                                  dataEmail +
                                  "&password=" +
                                  dataPassword;

                                  final response = await HTTP.post(url);

                                  final data = json.decode(response.body);


                                  print(data);

                                  if (data['status'] == true) {
                                    mainBloc.setretailerid(data['retailerid'].toString());
                                    Navigator.pushNamed(context, routeGotoSignin);
                                  } else {
                                    Navigator.pushNamed(context, routeGotoSignup);
                                  }
                                }
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(fontSize: 18, fontFamily: "Poppins-Medium"),
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
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, routeGotoSignin);
                      },
                      child: Text(
                        'Already have an account? Login Here',
                        style: TextStyle(fontSize: 18, fontFamily: "Poppins-Medium"),
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
}
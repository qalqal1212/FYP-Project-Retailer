import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:fyp_project_version3_retailer/bloc/main_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
 
 
class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  String retailerid;
  String passAmount;

  showQR() {
    return Container(
      child: QrImage(
        data: "retailerid='$retailerid'&amount='$passAmount'",
        version: QrVersions.auto,
        size: 30,
        gapless: false,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final MainBloc mainBloc = Provider.of<MainBloc>(context);
    retailerid = mainBloc.retailerid;
    passAmount = mainBloc.amount;


    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction'),
        centerTitle: true,
      ),
      body: passAmount == null ? PaymentCalculator() : PaymentQr(),
    );
  }
}

//Widget To Show Keypad 
class PaymentCalculator extends StatefulWidget {
  @override
  _PaymentCalculatorState createState() => _PaymentCalculatorState();
}

class _PaymentCalculatorState extends State<PaymentCalculator> {
  String retailerid;

  num numberFirst;
  num numberSecond;

  String numberDisplay = "";
  String numberDisplayTemp;
  String numberOperation;

  //Widget to paint keypad button
  
  Widget mybutton(String buttonText, int buttonFlex) {
    return Expanded(
      flex: buttonFlex,
      child: OutlineButton(
        onPressed: () => buttonProcess(buttonText),
        padding: EdgeInsets.all(25),
        child: Text(
          "$buttonText",
          style: Theme.of(context).textTheme.display1.apply(color: Colors.black),
        ),
      ),
    );
  }

  //Widget Show Dialog Box 
  showDialog() {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "CONFIRM PAYMENT",
      desc: "Confirm to continue transaction.",
      buttons: [
        DialogButton(
          child: Text(
            "CANCEL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.grey,
        ),
        DialogButton(
          child: Text(
            "CONFIRM",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(46, 204, 113, 1.0),
        )
      ],
    ).show();
  }

    //! METHOD TO HANDLE KEYPAD
  void buttonProcess(String buttonValue) async {
    if (buttonValue == "CLEAR") {
      numberFirst = 0;
      numberSecond = 0;

      numberDisplay = "";
      numberDisplayTemp = "";
    } else if (buttonValue == "CANCEL") {
      Navigator.pop(context);
    } else if (buttonValue == "CONFIRM") {
    } else if (buttonValue == ".") {
      numberDisplayTemp = numberDisplay + buttonValue;
    } else if (buttonValue == "+" || buttonValue == "-" || buttonValue == "X" || buttonValue == "/") {
      numberFirst = num.parse(numberDisplay);
      numberDisplayTemp = "";
      numberOperation = buttonValue;
    } else if (buttonValue == "=") {
      numberSecond = num.parse(numberDisplay);
      if (numberOperation == "+") {
        numberDisplayTemp = (numberFirst + numberSecond).toString();
      }
      if (numberOperation == "-") {
        numberDisplayTemp = (numberFirst - numberSecond).toString();
      }
      if (numberOperation == "X") {
        numberDisplayTemp = (numberFirst * numberSecond).toString();
      }
      if (numberOperation == "/") {
        numberDisplayTemp = (numberFirst ~/ numberSecond).toString();
      }
    } else {
      numberDisplayTemp = num.parse(numberDisplay + buttonValue).toString();
    }
    setState(() {
      numberDisplay = numberDisplayTemp.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final MainBloc mainBloc = Provider.of<MainBloc>(context);
    retailerid = mainBloc.retailerid;

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              '$numberDisplay',
              style: TextStyle(color: Colors.black, fontSize: 40),
            ),
          ),
        ),
        Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  mybutton('CLEAR', 3),
                  mybutton('%', 1),
                ],
              ),
              Row(
                children: <Widget>[
                  mybutton('7', 1),
                  mybutton('8', 1),
                  mybutton('9', 1),
                  mybutton('/', 1),
                ],
              ),
              Row(
                children: <Widget>[
                  mybutton('4', 1),
                  mybutton('5', 1),
                  mybutton('6', 1),
                  mybutton('x', 1),
                ],
              ),
              Row(
                children: <Widget>[
                  mybutton('1', 1),
                  mybutton('2', 1),
                  mybutton('3', 1),
                  mybutton('-', 1),
                ],
              ),
              Row(
                children: <Widget>[
                  mybutton('.', 1),
                  mybutton('0', 1),
                  mybutton('=', 1),
                  mybutton('+', 1),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: OutlineButton(
                      onPressed: () => buttonProcess("CANCEL"),
                      padding: EdgeInsets.all(25),
                      color: Colors.redAccent,
                      child: Text('CANCEL'),
                    ),
                  ),
                  Expanded(
                    child: OutlineButton(
                      onPressed: () {
                        buttonProcess("CONFIRM");
                        mainBloc.setamount(numberDisplay.toString());
                        print(mainBloc.amount);
                      },
                      padding: EdgeInsets.all(25),
                      color: Colors.green,
                      child: Text('CONFIRM'),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

//! WIDGET TO SHOW QR CODE
class PaymentQr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MainBloc mainBloc = Provider.of<MainBloc>(context);

    return Center(
      child: Container(
        child: QrImage(
          data: mainBloc.amount.toString(),
          version: QrVersions.auto,
          size: 320,
          gapless: false,
        ),
      ),
    );
  }
}
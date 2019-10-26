import 'package:flutter/material.dart';

class MainBloc extends ChangeNotifier {
  String _retailerid;
  String _amount;

  String get retailerid => _retailerid;

  set retailerid(String dataId) {
    _retailerid = dataId;
    notifyListeners();
  }

  setretailerid(String dataId) {
    _retailerid = dataId;
    notifyListeners();
  }

  myretailerid() {
    retailerid;
  }

  String get amount => _amount;

  set amount(String dataAmount) {
    _amount = dataAmount;
    notifyListeners();
  }

  setamount(String dataAmount) {
    _amount = dataAmount;
    notifyListeners();
  }

  myamount() {
    amount;
  }


}
import 'package:equatable/equatable.dart';

class History extends Equatable {
  final String dataID;
  final String dataDateTime;
  final String dataAmount;

  History({this.dataID, this.dataDateTime, this.dataAmount}) : super([dataID, dataDateTime, dataAmount]);

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      dataID: json['transactionid'],
      dataDateTime: json['created_at'],
      dataAmount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transactionid'] = this.dataID;
    data['created_at '] = this.dataDateTime;
    data['amount'] = this.dataAmount;
    return data;
  }
}
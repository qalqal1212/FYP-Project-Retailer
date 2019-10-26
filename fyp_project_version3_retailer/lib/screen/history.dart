import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as HTTP;
import 'package:provider/provider.dart';
import 'package:fyp_project_version3_retailer/bloc/main_bloc.dart';
import 'package:fyp_project_version3_retailer/model/mymodel.dart';

class ScreenHistory extends StatefulWidget {
  @override
  _ScreenHistoryState createState() => _ScreenHistoryState();
}

class _ScreenHistoryState extends State<ScreenHistory> {
  String retailerid;

  List<History> historyList = List<History>();

  //Future For History Purchase 
  Future<List<History>> serviceHistory() async {
    String url = "http://10.0.2.2/fyp_project_api_version_1.0/api/history/historyretailer.php?retailerid=" + retailerid;
    final response = await HTTP.get(url);
    final data = json.decode(response.body);

    data.forEach((object) {
      historyList.add(History.fromJson(object));
    });

    return historyList;
  }
  @override
  Widget build(BuildContext context) {
    final MainBloc mainBloc = Provider.of<MainBloc>(context);
    retailerid = mainBloc.retailerid;

    return Scaffold(
        appBar: AppBar(
          title: Text('History'),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: serviceHistory(),
            builder: (context, snapshot) {
              return ListView.separated(
                  itemCount: historyList.length < 21 ? historyList.length : 20,
                  itemBuilder: (context, snapshot) {
                    return ListTile(
                      title: Text(
                        "ID : ${historyList[snapshot].dataID}",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text("${historyList[snapshot].dataDateTime}"),
                      trailing: Text("RM ${historyList[snapshot].dataAmount}",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          )),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  });
            }));
  }
}
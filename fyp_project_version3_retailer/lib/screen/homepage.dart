import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fyp_project_version3_retailer/bloc/main_bloc.dart';
import 'package:fyp_project_version3_retailer/core/myroute.dart';
import 'package:fyp_project_version3_retailer/screen/screen.dart';
 
 
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String retailerid;

  int indexScreenCurrent = 0;

  final List<Widget> indexScreen = [
    ScreenHome(),
    ScreenHistory(),
    
  ];

  void indexScreenTap(int indexTap) {
    setState(() {
     indexScreenCurrent = indexTap; 
    });
  }

  @override
  Widget build(BuildContext context) {
    final MainBloc mainBloc = Provider.of<MainBloc>(context);
    retailerid = mainBloc.retailerid;
    print(retailerid);

   return Scaffold(
     backgroundColor: Colors.orange,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, routeGotoPayment);
        },
        child: Icon(Icons.add_circle_outline),
      ),
      body: indexScreen[indexScreenCurrent],
      bottomNavigationBar: BottomNavigationBar(
        onTap: indexScreenTap,
        currentIndex: indexScreenCurrent,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(
                'Home',
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text(
                'History',
              )),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
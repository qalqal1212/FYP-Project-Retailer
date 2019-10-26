import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fyp_project_version3_retailer/bloc/main_bloc.dart';
import 'package:fyp_project_version3_retailer/screen/screen.dart';

import 'package:fyp_project_version3_retailer/core/route_generator.dart' as route;

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final titleEwallet = "EWallet";

  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => MainBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: route.routeGenerator,
        title: titleEwallet,
        home: ScreenSplash(),
      ),
    );
  }
}
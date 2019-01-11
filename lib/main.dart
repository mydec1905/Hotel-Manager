import 'package:flutter/material.dart';
import 'package:hotel_manager/screen/main_screen.dart';
import 'screen/launch_screen.dart';


void main() => runApp(MaterialApp(
  title: ' Example App',
home: MyApp(),
//  home: LaunchScreen(),routes: <String , WidgetBuilder>{
//    '/CustomerList':(BuildContext context)=>CustomerList()
//},
  theme: ThemeData(primarySwatch: Colors.lightGreen)
));
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  @override
  Widget build(BuildContext context) {
    return CustomerList();
  }
}





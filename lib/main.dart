import 'package:flutter/material.dart';
import 'package:hotel_manager/screen/main_screen.dart';


void main() => runApp(MaterialApp(
  title: ' Example App',
  home: MyApp(),
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





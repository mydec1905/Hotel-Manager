import 'package:flutter/material.dart';
import 'package:first_app/screen/main_screen.dart';
import 'package:first_app/model.dart';

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





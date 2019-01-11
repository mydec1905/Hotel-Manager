import 'dart:async';
import 'package:flutter/material.dart';
class LaunchScreen extends StatefulWidget {
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }
  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/CustomerList');
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('image/hotel1.jpg',fit: BoxFit.cover,),
      ),
    );
  }
}

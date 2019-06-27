import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hotel_manager/route/routes.dart';
import 'package:hotel_manager/theme/image.dart';
import 'package:hotel_manager/widgets/global_data.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3));
    GlobalData.staticDelayOpenScreenByPath(context, Routes.mainScreen,);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: Container(
        child: Image.asset(Images.logo,),
      ),
    );
  }
}

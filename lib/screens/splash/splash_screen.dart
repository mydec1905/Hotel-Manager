import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hotel_manager/route/routes.dart';
import 'package:hotel_manager/screens/components/global_data.dart';
import 'package:hotel_manager/theme/image.dart';

import '../main_screen.dart';

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
    GlobalData.staticDelayOpenScreenByPath(context, Routes.mainScreen);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: Container(
        child: Image.asset(Images.background,fit: BoxFit.cover,),
      ),
    );
  }
}

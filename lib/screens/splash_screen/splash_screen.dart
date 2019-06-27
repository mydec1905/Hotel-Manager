import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hotel_manager/route/routes.dart';
import 'package:hotel_manager/theme/color.dart';
import 'package:hotel_manager/theme/image.dart';
import 'package:hotel_manager/widgets/global_data.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
    GlobalData.staticDelayOpenScreenByPath(
      context,
      Routes.mainScreen,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox.fromSize(
                size: Size(150.0, 150.0),
                child: Image.asset(Images.logo),
              ),
              SpinKitRipple(color: AppColors.primary,)
            ],
          ),
        ),
      ),
    );
  }
}

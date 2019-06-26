import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:hotel_manager/screens/main_screen/main_screen.dart';
import 'package:hotel_manager/screens/splash_screen/splash_screen.dart';

var splashScreenHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params){
    return SplashScreen();
  }
);
var mainScreenHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params){
      return MainScreen();
    }
);

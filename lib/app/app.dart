import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:hotel_manager/screens/route/routes.dart';
import 'package:hotel_manager/screens/splash/splash_screen.dart';
import 'package:hotel_manager/theme/color.dart';


class TravelApp extends StatelessWidget {
  static Router router;
  TravelApp({Key key}):super(key : key){
    final router = Router();
    Routes.configureRoutes(router);
    TravelApp.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: AppColors.primary,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        primarySwatch: Colors.grey
      ),
      home: SplashScreen(),
    );
  }
}

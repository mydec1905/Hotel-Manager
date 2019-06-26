import 'package:flutter/material.dart';
import 'dart:async';

import 'package:hotel_manager/app/app.dart';
class GlobalData{
 static staticDelayOpenScreenByPath(BuildContext context,String path)async{
   await Future.delayed(Duration(seconds: 3));
   TravelApp.router.navigateTo(context, path,replace: true);
 }
 static staticOpenScreenByPath(BuildContext context,String path)async{
   TravelApp.router.navigateTo(context, path,replace: true);
 }
}
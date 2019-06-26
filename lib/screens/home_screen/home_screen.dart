import 'package:flutter/material.dart';
import 'package:hotel_manager/constants/constants.dart';
import 'package:hotel_manager/screens/main_screen/animate_menu.dart';
import 'package:hotel_manager/theme/image.dart';
final Screen homeScreen = Screen(
    title: Constants.idHomeScreen.toUpperCase(),
    background: new DecorationImage(
      image: new AssetImage(Images.background),
      fit: BoxFit.cover,
    ),
    contentBuilder: (BuildContext context){
      return
        Center(child: Text('BUILDING'),);
    }
);
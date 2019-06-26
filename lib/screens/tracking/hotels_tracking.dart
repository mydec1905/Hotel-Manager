import 'package:flutter/material.dart';
import 'package:hotel_manager/screens/main_screen/animate_menu.dart';
import 'package:hotel_manager/theme/image.dart';
final Screen hotels_tracking_screen = Screen(
  title: 'HOTELS TRACKING',
  background: new DecorationImage(
    image: new AssetImage(Images.background),
    fit: BoxFit.cover,
  ),
  contentBuilder: (BuildContext context){
    return
        Center(child: Text('BUILDING'),);
  }
);
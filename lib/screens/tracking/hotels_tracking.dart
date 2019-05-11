import 'package:flutter/material.dart';
import 'package:hotel_manager/screens/menu/animate_menu.dart';
final Screen hotels_tracking_screen = Screen(
  title: 'HOTELS TRACKING',
  background: new DecorationImage(
    image: new AssetImage('assets/Sea_and_sky_light.jpg'),
    fit: BoxFit.cover,
  ),
  contentBuilder: (BuildContext context){
    return
        Center(child: Text('BUILDING'),);
  }
);
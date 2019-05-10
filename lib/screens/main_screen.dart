import 'package:flutter/material.dart';
import 'package:hotel_manager/screens/tours_detail/toursdetail.dart';

import 'package:hotel_manager/screens/menu/animate_menu.dart';
import 'package:hotel_manager/screens/menu/menu.dart';
import 'package:hotel_manager/screens/tours_booking/toursbooking.dart';
import 'package:hotel_manager/screens/tracking/hotels_tracking.dart';
import 'package:hotel_manager/screens/tracking/tours_tracking.dart';


import 'hotel_booking/hotelsbooking.dart';
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final menu = new Menu(
    items: [
      new MenuItem(
        id: 'toursbooking',
        title: 'TOURS BOOKING',
      ),
      new MenuItem(
        id: 'hotelsbooking',
        title: 'HOTEL BOOKING',
      ),
      new MenuItem(
        id: 'tourstracking',
        title: 'TOURS TRACKING',
      ),
      new MenuItem(
        id: 'hotelstracking',
        title: 'HOTELS TRACKING',
      ),
    ],
  );

  var selectedMenuItemId = 'restaurant';
  var activeScreen = toursBooking;

  @override
  Widget build(BuildContext context) {
    return new ZoomScaffold(
      menuScreen: new MenuScreen(
        menu: menu,
        selectedItemId: selectedMenuItemId,
        onMenuItemSelected: (String itemId) {
          if (itemId == 'toursbooking') {
            setState(() {
              activeScreen = toursBooking;
            });
          }else if(itemId == 'hotelsbooking'){
            setState(() {
              activeScreen = hotelsBooking;
            });
          }
          else if(itemId == 'tourstracking'){
            setState(() {
              activeScreen = tours_tracking_screen;
            });
          }
          else if(itemId == 'hotelstracking'){
            setState(() {
              activeScreen = hotels_tracking_screen;
            });
          }

        },
      ),
      contentScreen: activeScreen,
    );
  }
}

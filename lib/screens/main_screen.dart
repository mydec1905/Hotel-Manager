import 'package:flutter/material.dart';
import 'package:hotel_manager/screens/tours_detail/toursdetail.dart';

import 'package:hotel_manager/screens/menu/animate_menu.dart';
import 'package:hotel_manager/screens/menu/menu.dart';
import 'package:hotel_manager/screens/tours_booking/toursbooking.dart';

import 'chart/chart_screen.dart';
import 'hotel_booking/hotelbooking.dart';
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final menu = new Menu(
    items: [
      new MenuItem(
        id: 'toursdetail',
        title: 'TOURS DETAIL',
      ),
      new MenuItem(
        id: 'toursbooking',
        title: 'TOUR BOOKING',
      ),
      new MenuItem(
        id: 'hotelbooking',
        title: 'HOTEL BOOKING',
      ),
      new MenuItem(
        id: 'chart',
        title: 'CHART',
      ),
    ],
  );

  var selectedMenuItemId = 'restaurant';
  var activeScreen = toursDetails;

  @override
  Widget build(BuildContext context) {
    return new ZoomScaffold(
      menuScreen: new MenuScreen(
        menu: menu,
        selectedItemId: selectedMenuItemId,
        onMenuItemSelected: (String itemId) {
          selectedMenuItemId = itemId;
          if (itemId == 'toursdetail') {
            setState(() {
              activeScreen = toursDetails;
            });
          }else if(itemId == 'toursbooking'){
            setState(() {
              activeScreen = toursBooking;
            });
          }
          else if(itemId == 'hotelbooking'){
            setState(() {
              activeScreen = hotelBooking;
            });
          }
          else if(itemId == 'chart'){
            setState(() {
              activeScreen = chart;
            });
          }

        },
      ),
      contentScreen: activeScreen,
    );
  }
}

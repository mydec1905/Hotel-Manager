import 'package:flutter/material.dart';
import 'package:hotel_manager/constants/constants.dart';
import 'package:hotel_manager/screens/home_screen/home_screen.dart';
import 'package:hotel_manager/screens/hotel_screen/hotelsbooking.dart';
import 'package:hotel_manager/screens/main_screen/animate_menu.dart';
import 'package:hotel_manager/screens/main_screen/menu.dart';
import 'package:hotel_manager/screens/tour_screen/toursbooking.dart';
import 'package:hotel_manager/screens/tracking/hotels_tracking.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final menu =  Menu(
    items: [
       MenuItem(
        id: Constants.idHomeScreen,
        title: Constants.idHomeScreen.toUpperCase(),
      ),
       MenuItem(
        id: Constants.idHotelScreen,
        title: Constants.idHotelScreen.toUpperCase(),
      ),
       MenuItem(
        id: Constants.idTourScreen,
        title: Constants.idTourScreen.toUpperCase(),
      ),
       MenuItem(
        id: Constants.idChartScreen,
        title: Constants.idChartScreen.toUpperCase(),
      ),
    ],
  );

  var selectedMenuItemId;

  var activeScreen = homeScreen;

  @override
  Widget build(BuildContext context) {
    return new ZoomScaffold(
      menuScreen:  MenuScreen(
        menu: menu,
        selectedItemId: selectedMenuItemId,
        onMenuItemSelected: (String itemId) {
          if (itemId == Constants.idHomeScreen) {
            setState(() {
              activeScreen = homeScreen;
            });
          } else if (itemId == Constants.idHotelScreen) {
            setState(() {
              activeScreen = hotelsBooking;
            });
          } else if (itemId == Constants.idTourScreen) {
            setState(() {
              activeScreen = toursBooking;
            });
          } else if (itemId == Constants.idChartScreen) {
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

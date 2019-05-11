
import 'package:flutter/material.dart';
import 'package:hotel_manager/key_data/key_tour_data.dart';
import 'package:hotel_manager/screens/menu/animate_menu.dart';
import 'package:hotel_manager/screens/tracking/tours_progress.dart';
import 'package:hotel_manager/theme/color.dart';
import 'package:flutter/cupertino.dart';
import 'tours_chart.dart';
final Screen tours_tracking_screen = new Screen(
    title: 'TOURS TRACKING',
    background: new DecorationImage(
      image: new AssetImage('assets/Sea_and_sky_light.jpg'),
      fit: BoxFit.cover,
    ),
    contentBuilder: (BuildContext context) {
      return
        ChartScreen();
    });



class ChartScreen extends StatefulWidget {
  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;


  List<Widget> _tabList = [
    Container(
      color: Colors.transparent,
      child: TourChart(),
    ),
    Container(
      child: TourProgress(),
      color: Colors.transparent,
    ),


  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabList.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: TabBarView(children: _tabList,controller: _tabController,),
      bottomNavigationBar: BottomNavigationBar(


       // backgroundColor: Colors.transparent,
        currentIndex: _currentIndex,
        onTap: (index){

          setState(() {
            _currentIndex = index;
          });

          _tabController.animateTo(_currentIndex);

        },
        items: [
          BottomNavigationBarItem(
              title: Text("CHART"),
            icon: Icon(Icons.show_chart)

          ),
          BottomNavigationBarItem(
              title: Text("PROGRESS"),
              icon: Icon(Icons.account_balance)
          ),

        ],
      ),
    );
  }
}




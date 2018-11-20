
import 'package:flutter/material.dart';
import 'package:hotel_manager/model.dart';
import 'package:hotel_manager/screen/hotel1.dart';
import 'package:hotel_manager/screen/hotel2.dart';
import 'package:hotel_manager/screen/hotel3.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerList extends StatefulWidget {
  final List<Customer> info;

  CustomerList({Key key, this.info}) : super(key: key);

  @override
  _CustomerListState createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList>
    with SingleTickerProviderStateMixin {
  List<Customer> danhsach1 = new List<Customer>();
  List<Customer> danhsach2 = new List<Customer>();
  List<Customer> danhsach3 = new List<Customer>();
  TabController tabController;
  ScrollController scrollViewController;
  final dateFormat = DateFormat.yMd();
  TextEditingController noted = TextEditingController();

  @override
  void initState() {
    super.initState();
    tabController = new TabController(vsync: this, length: 3);
    scrollViewController = new ScrollController();
  }

  @override
  void dispose() {
    tabController.dispose();
    scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Tab> myTabs = <Tab>[
      Tab(text: 'Hotel1'),
      Tab(text: 'Hotel2'),
      Tab(text: 'Hotel3'),
    ];
    return new Scaffold(
        appBar: AppBar(
          title: Text('Customer List'),
          bottom: TabBar(
            tabs: myTabs,
            controller: tabController,
          ),
        ),
        body: new TabBarView(
          controller: tabController,
          children: <Widget>[
            Hotel1(
              info1: danhsach1,
            ),
            Hotel2(
              info2: danhsach2,
            ),
            Hotel3(
              info3: danhsach3,
            )
          ],
        ));
  }
}

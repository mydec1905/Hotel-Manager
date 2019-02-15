//import 'package:flutter/material.dart';
//
//import 'package:hotel_manager/model.dart';
//import 'package:hotel_manager/screen/edit.dart';
//import 'package:hotel_manager/screen/input3.dart';
//
//import 'package:hotel_manager/database_helper.dart';
//import 'package:intl/intl.dart';
//import 'package:url_launcher/url_launcher.dart';
//import 'dart:async';
//
//class Hotel3 extends StatefulWidget {
//  final List<Customer> info3;
//
//  Hotel3({Key key, this.info3}) : super(key: key);
//
//  @override
//  _Hotel3State createState() => _Hotel3State();
//}
//
//class _Hotel3State extends State<Hotel3> {
//  Future<List<Customer>> fetchCustomersFromDatabase() async {
//    var dbHelper = DBHelper();
//    Future<List<Customer>> customer = dbHelper.getCustomers();
//    return customer;
//  }
//
//  final dateFormat = DateFormat.yMd();
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Container(
//          child: FutureBuilder<List<Customer>>(
//        future: fetchCustomersFromDatabase(),
//        builder: (context, snapshot) {
//          return ListView.builder(
//            itemCount: snapshot.data?.length ?? 0,
//            itemBuilder: (context, index) {
//              final cardColor =
//                  index % 2 == 0 ? Colors.pinkAccent : Colors.yellowAccent;
//              return Container(
//                color: cardColor,
//                child: ExpansionTile(
//                  title: Stack(
//                    children: <Widget>[
//                      Align(
//                        alignment: Alignment.topLeft,
//                        child: Text('${snapshot.data[index].name}'),
//                      ),
//                      Align(
//                        alignment: Alignment.topRight,
//                        child: Text('${snapshot.data[index].datestart}'),
//                      )
//                    ],
//                  ),
//                  children: <Widget>[
//                    Card(
//                      child: Column(
//                        children: <Widget>[
//                          Row(
//                            children: <Widget>[
//                              Expanded(
//                                  child: Text(
//                                      '''Name : ${snapshot.data[index].name}\nPhone: ${snapshot.data[index].phone}\nPrepaid: ${snapshot.data[index].paid} VND\nStart: ${snapshot.data[index].datestart}\nEnd :  ${snapshot.data[index].dateend}
//                              ''')),
//                              IconButton(
//                                  icon: Icon(Icons.phone),
//                                  onPressed: () => launch(
//                                      "tel:${snapshot.data[index].phone}")),
//                              IconButton(
//                                icon: Icon(Icons.edit),
//                                onPressed: () {
//                                  // snapshot.info3.removeAt(index);
//                                  Navigator.push(
//                                      context,
//                                      MaterialPageRoute(
//                                          builder: (context) => Edit(
//                                                index: index,
//                                                temp: snapshot.data,
//                                              )));
//                                },
//                              ),
//                              IconButton(
//                                  icon: Icon(Icons.delete_forever),
//                                  onPressed: () {
//                                    showDialog(
//                                        context: context,
//                                        builder: (BuildContext context) {
//                                          return AlertDialog(
//                                            content: Text('Are you sure'),
//                                            actions: <Widget>[
//                                              FlatButton(
//                                                onPressed: () {
//                                                  deleteCustomer(index);
//                                                  setState(() {});
//                                                  Navigator.pop(context);
//                                                },
//                                                child: Text('Yes'),
//                                              ),
//                                              FlatButton(
//                                                onPressed: () {
//                                                  Navigator.pop(context);
//                                                },
//                                                child: Text('No'),
//                                              )
//                                            ],
//                                          );
//                                        });
//                                  })
//                            ],
//                          ),
//                        ],
//                      ),
//                    )
//                  ],
//                ),
//              );
//            },
//          );
//        },
//      )),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {
//          Navigator.push(
//              context,
//              MaterialPageRoute(
//                  builder: (context) => Input(
//                        infotemp: widget.info3,
//                      )));
//        },
//        child: Icon(Icons.add),
//      ),
//    );
//  }
//
//  deleteCustomer(int index) {
//    widget.info3.removeAt(index);
//  }
//}


import 'package:flutter/material.dart';
import 'package:hotel_manager/model.dart';
import 'package:hotel_manager/screen/edit.dart';
import 'package:hotel_manager/screen/input.dart';

import 'package:intl/intl.dart';

import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Hotel2 extends StatefulWidget {
  final List<Customer> info2;

  Hotel2({Key key, this.info2}) : super(key: key);

  @override
  _Hotel2State createState() => _Hotel2State();
}

class _Hotel2State extends State<Hotel2> {
  final dateFormat = DateFormat.yMd();
  TextEditingController noted = TextEditingController();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: widget.info2?.length ?? 0,
          itemBuilder: (context, index) {
            final cardColor =
            index % 2 == 0 ? Colors.pinkAccent : Colors.yellowAccent;
            return Container(
              color: cardColor,
              child: ExpansionTile(
                title: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text('${widget.info2[index].name}'),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text('${widget.info2[index].datestart}'),
                    )
                  ],
                ),
                children: <Widget>[
                  Card(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                                child: Text(
                                    '''Name : ${widget.info2[index].name}\nPhone: ${widget.info2[index].phone}\nPrepaid: ${widget.info2[index].paid} VND\nStart: ${widget.info2[index].datestart}\nEnd :  ${widget.info2[index].dateend}
                              ''')),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                // widget.info3.removeAt(index);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Edit(
                                          index: index,
                                          temp: widget.info2,
                                        )));
                              },
                            ),
                            IconButton(
                                icon: Icon(Icons.delete_forever),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Text('Are you sure'),
                                          actions: <Widget>[
                                            FlatButton(
                                              onPressed: () {
                                                deleteCustomer(index);
                                                setState(() {});
                                                Navigator.pop(context);
                                              },
                                              child: Text('Yes'),
                                            ),
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('No'),
                                            )
                                          ],
                                        );
                                      });
                                })
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Input(infotemp: widget.info2)));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  deleteCustomer(int index) {
    widget.info2.removeAt(index);
  }
}

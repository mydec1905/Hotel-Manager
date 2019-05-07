import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_manager/screens/components/custom_appbar.dart';
import 'package:intl/intl.dart';

class AddCustomer extends StatefulWidget {
  @override
  _AddCustomerState createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  List<DropdownMenuItem<String>> listDrop = [];
  DateTime selectedDate = DateTime.now();
  String name, phone, quality, pickupLocation, key;

  final _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static final List<String> locationList = <String>[
    'Phu Quoc',
    'Nha Trang',
    'Hoi An'
  ];

  static List<String> tourPhuQuoc = <String>[
    'Phu Quoc 1',
    'Phu Quoc 2',
    'Phu Quoc 3',
    'Phu Quoc 4'
  ];
  static List<String> tourNhaTrang = <String>[
    'Nha Trang 1',
    'Nha Trang 2',
    'Nha Trang 3',
    'Nha Trang 4',
  ];
  static List<String> tourHoiAn = <String>[
    'Hoi An 1',
    'Hoi An 2',
    'Hoi An 3',
    'Hoi An 4',
  ];
  static List<String> itemList = <String>[];
  String locationSelected = 'Phu Quoc';
  String tourSelectedTemp = 'Phu Quoc 1';
  String tourSelected = '';

  void loadItem() {
    if (locationSelected == 'Phu Quoc') {
      setState(() {
        itemList = tourPhuQuoc;
        key = 'PQ';
        print('---->$itemList');
      });
      tourSelected = 'Phu Quoc 1';
    } else if (locationSelected == 'Nha Trang') {
      setState(() {
        itemList = tourNhaTrang;
        key = 'NT';
        print('---->$itemList');
      });
      tourSelected = 'Nha Trang 1';
    }else if (locationSelected == 'Hoi An') {
      setState(() {
        itemList = tourHoiAn;
        key = 'NT';
        print('---->$itemList');
      });
      tourSelected = 'Hoi An 1';
    }
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/Sea_and_sky_light.jpg'),
                fit: BoxFit.cover)),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: CustomAppBar(
                  height: 60,
                  title: 'ADD CUSTOMER',
                  icon: Icon(Icons.arrow_back_ios),
                  iconFunction: () {
                    setState(() {
                      itemList = [];
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        autovalidate: false,
                        textCapitalization: TextCapitalization.characters,
                        validator: (value) {
                          if (value.isEmpty) return 'Input Name';
                        },
                        decoration: InputDecoration(
                            hintText: 'Name',
                            hintStyle: TextStyle(color: Colors.grey)),
                        onSaved: (value) => this.name = value,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.numberWithOptions(),
                        autovalidate: false,
                        validator: (value) {
                          if (value.isEmpty) return 'Input Phone';
                        },
                        decoration: InputDecoration(
                            hintText: 'Phone',
                            hintStyle: TextStyle(color: Colors.grey)),
                        onSaved: (value) => this.phone = value,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.numberWithOptions(),
                        autovalidate: false,
                        validator: (value) {
                          if (value.isEmpty) return 'Input Quality';
                        },
                        decoration: InputDecoration(
                            hintText: 'Quality',
                            hintStyle: TextStyle(color: Colors.grey)),
                        onSaved: (value) => this.quality = value,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.characters,
                        autovalidate: false,
                        validator: (value) {
                          if (value.isEmpty) return 'Input Pickup Location';
                        },
                        decoration: InputDecoration(
                            hintText: 'Pick Up Location',
                            hintStyle: TextStyle(color: Colors.grey)),
                        onSaved: (value) => this.pickupLocation = value,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: DropdownButtonHideUnderline(
                        child: Column(
                          children: <Widget>[
                            InputDecorator(
                              decoration: InputDecoration(
                                  labelText: 'Location',
                                  labelStyle: TextStyle(fontSize: 25)),
                              //isEmpty: locationSelected == null,
                              child: new DropdownButton<String>(
                                value: locationSelected,
                                isDense: true,
                                onChanged: (String newValue) {
                                  setState(() {
                                    locationSelected = newValue;
                                    print(locationSelected);
                                    loadItem();
                                  });
                                },
                                items: locationList.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlatButton(
                            child: Text(
                              DateFormat('dd-MM-yyyy').format(selectedDate),
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () => _selectDate(context))),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: DropdownButtonHideUnderline(
                  child: Column(
                    children: <Widget>[
                      InputDecorator(
                        decoration: InputDecoration(
                            labelText: 'Select Tour',
                            labelStyle: TextStyle(fontSize: 25)),
                        isEmpty: tourSelected == null,
                        child: new DropdownButton<String>(
                          value: tourSelected,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              tourSelected = newValue;
                              print(tourSelected);
                            });
                          },
                          items: itemList.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    save();
                    //updateCountBooking();

                    _formKey.currentState.reset();
                    Navigator.pop(context);
                    setState(() {
                      itemList = [];
                    });
                  }
                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Icon(Icons.save), Text('Save')],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> save() async {
    final Firestore _firestore = Firestore.instance;
    DocumentReference reference =
        _firestore.collection('TOUR_BOOKING_LIST').document();
    return reference.setData({
      'name': name,
      'phone': phone,
      'quality': quality,
      'pick_up_location': pickupLocation,
      'date': DateFormat('dd-MM-yyyy').format(selectedDate),
      'tour': tourSelected,
      'location': locationSelected,
      'key': key,
      'time': DateTime.now().millisecondsSinceEpoch,
    }).whenComplete(() {
      print('saved');
      //  updateCountBooking();
    }).whenComplete(() {
      final DocumentReference reference = Firestore.instance
          .collection('TOURS_DETAIL')
          .document(locationSelected);
      Firestore.instance.runTransaction((Transaction transaction) async {
        DocumentSnapshot snapshot = await transaction.get(reference);
        if (snapshot.exists) {
          await transaction.update(reference, <String, dynamic>{
            'book_count': snapshot.data['book_count'] + int.parse(quality)
          });
          print('snapshot exists');
        } else {
          print('error');
        }
      }).catchError((e) {
        print(e);
      });
    });
  }
}

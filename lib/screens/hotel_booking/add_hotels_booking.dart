import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_manager/key_data/key_hotel_data.dart';
import 'package:hotel_manager/screens/components/custom_appbar.dart';
import 'package:hotel_manager/screens/hotel_booking/list_hotel_data.dart';
import 'package:intl/intl.dart';

class AddHotelCustomer extends StatefulWidget {
  @override
  _AddHotelCustomerState createState() => _AddHotelCustomerState();
}

class _AddHotelCustomerState extends State<AddHotelCustomer> {
  // List<DropdownMenuItem<String>> listDrop = [];
  CustomerHotel customerHotel = CustomerHotel();
  Room room = Room();

  DateTime datecheckout = DateTime.now();
  DateTime datecheckin = DateTime.now();
  String name, phone, quality;

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static List<String> itemList = <String>[];
  String hotelSelected = 'KS Hoàng Hưng Quy Nhơn';

  //String tourSelectedTemp = 'Phu Quoc 1';
  String roomSelected = '';

  void loadItem() {
    if (hotelSelected == 'KS Hoàng Hưng Quy Nhơn') {
      setState(() {
        itemList = KeyHotelData.hotelQuyNhon;
        print('---->$itemList');
      });
      roomSelected = 'Phòng Đơn';
    } else if (hotelSelected == 'KS Bạch Dương Phú Yên') {
      setState(() {
        itemList = KeyHotelData.hotelPhuYen;
        print('---->$itemList');
      });
      roomSelected = 'Phòng Đôi Không Cửa Sổ - 1m6';
    }
  }

  Future<Null> _checkout(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != customerHotel.checkout)
      setState(() {
        customerHotel.checkout = picked;
      });
  }

  Future<Null> _checkin(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != customerHotel.checkin)
      setState(() {
        customerHotel.checkin = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    customerHotel.checkin = DateTime.now();
    customerHotel.checkout = DateTime.now();
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
                        onSaved: (value) => this.customerHotel.name = value,
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
                        onSaved: (value) => this.customerHotel.phone = value,
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
                        child: FlatButton(
                            child: Text(
                              DateFormat('dd-MM-yyyy')
                                  .format(customerHotel.checkin),
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () => _checkin(context))),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlatButton(
                            child: Text(
                              DateFormat('dd-MM-yyyy')
                                  .format(customerHotel.checkout),
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () => _checkout(context))),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: DropdownButtonHideUnderline(
                        child: Column(
                          children: <Widget>[
                            InputDecorator(
                              decoration: InputDecoration(
                                  labelText: 'Hotel',
                                  labelStyle: TextStyle(fontSize: 25)),
                              //isEmpty: locationSelected == null,
                              child: new DropdownButton<String>(
                                value: hotelSelected,
                                isDense: true,
                                onChanged: (String newValue) {
                                  setState(() {
                                    hotelSelected = newValue;
                                    customerHotel.hotel = hotelSelected;
                                    print(customerHotel.hotel);
                                    loadItem();
                                  });
                                },
                                items:
                                    KeyHotelData.hotelList.map((String value) {
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
                      child: TextFormField(
                        keyboardType: TextInputType.numberWithOptions(),
                        autovalidate: false,
                        validator: (value) {
                          if (value.isEmpty) return 'Input Quality';
                        },
                        decoration: InputDecoration(
                            hintText: 'Quality',
                            hintStyle: TextStyle(color: Colors.grey)),
                        onSaved: (value) {room.quality = value;

                        }
                      ),
                    ),
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
                            labelText: 'Select Room',
                            labelStyle: TextStyle(fontSize: 25)),
                        isEmpty: roomSelected == null,
                        child: new DropdownButton<String>(
                          value: roomSelected,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              roomSelected = newValue;
                              room.title = roomSelected;
                              print(room.title);
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

    customerHotel.room2.add(room.toMap());
    final Firestore _firestore = Firestore.instance;
    DocumentReference reference =
        _firestore.collection('HOTEL_BOOKING_LIST').document();
    return reference.setData({
      'name': customerHotel.name,
      'phone': customerHotel.phone,
      'check_in': DateFormat('dd-MM-yyyy').format(customerHotel.checkin),
      'check_out': DateFormat('dd-MM-yyyy').format(customerHotel.checkout),
      'hotel': customerHotel.hotel,
      'time': DateTime.now().millisecondsSinceEpoch,
      'room': customerHotel.room2
    }).catchError((e) {
      if(room == null){
        print('null');
      }
      print(e);
    }).whenComplete(() {
      final DocumentReference reference =
          Firestore.instance.collection(hotelSelected).document(roomSelected);
      Firestore.instance.runTransaction((Transaction transaction) async {
        DocumentSnapshot snapshot = await transaction.get(reference);
        if (snapshot.exists) {
          await transaction.update(reference, <String, dynamic>{
            'book_count': snapshot.data['book_count'] + int.parse(quality),
            'time_update': DateTime.now().toIso8601String()
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

//Room _room = Room(title: '123',quality: '1234');

class CustomerHotel {
  String name;
  String phone;
  String hotel;
  DateTime checkin;
  DateTime checkout;
  List<Map<dynamic, dynamic>> room2 = [];


}

class Room {
    String title;
   String quality;

   Room({this.title,this.quality});
  Map<String, dynamic> toMap() => {'title': title, 'quality': quality};

}

import 'package:flutter/material.dart';
import 'package:hotel_manager/model.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class Input extends StatefulWidget {
  final Customer customer;

  Input(this.customer);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InputState();
  }
}

class InputState extends State<Input> {
  final database = FirebaseDatabase.instance.reference().child("hotel2");
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController paidcontroller = TextEditingController();
  DateTime start = DateTime.now();
  DateTime end = DateTime.now();
  final dateFormat = DateFormat.yMd();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  String name;
  String phone;
  String paid;
  String dateStart;
  String dateEnd;
  String id;

  Future<Null> _selectDatestart(BuildContext context) async {
    final DateTime datestart = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(0),
        lastDate: DateTime(3000));
    if (datestart != null && datestart != start)
      setState(() {
        start = datestart;
      });
  }

  Future<Null> _selectDateend(BuildContext context) async {
    final DateTime dateend = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(0),
        lastDate: DateTime(3000));
    if (dateend != null && dateend != end)
      setState(() {
        end = dateend;
      });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(''),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: namecontroller,
              autofocus: true,
              keyboardType: TextInputType.text,
              autocorrect: false,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                  labelText: 'Input Name', icon: Icon(Icons.person)),
              validator: (val) => val.length == 0 ? "Enter Name" : null,
              onSaved: (val) => this.name = val,
            ),
            TextFormField(
              controller: phonecontroller,
              autofocus: false,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Input Phone Number', icon: Icon(Icons.phone)),
              validator: (val) => val.length == 0 ? "Enter Phone Number" : null,
              onSaved: (val) => this.phone = val,
            ),
            TextFormField(
              controller: paidcontroller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'PrePaid', icon: Icon(Icons.attach_money)),
              validator: (val) => val.length == 0 ? "Enter Money" : null,
              onSaved: (val) => this.paid = val,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    _selectDatestart(context);
                  },
                  icon: Icon(Icons.calendar_today),
                ),
                Text('Date Start :\n${DateFormat.yMd().format(start)}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    _selectDateend(context);
                  },
                  icon: Icon(Icons.calendar_today),
                ),
                Text('Date End :\n${DateFormat.yMd().format(end)}'),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (widget.customer.id != null) {
            database.child(widget.customer.id).set({
              'name': '${namecontroller.text}',
              'phone': '${phonecontroller.text}',
              'paid': '${paidcontroller.text}',
              'start': '${DateFormat.yMd().format(start)}',
              'end': '${DateFormat.yMd().format(end)}'
            }).then((_) {
              Navigator.pop(context);
            });
          } else {
            database.push().set({
              'name': '${namecontroller.text}',
              'phone': '${phonecontroller.text}',
              'paid': '${paidcontroller.text}',
              'start': '${DateFormat.yMd().format(start)}',
              'end': '${DateFormat.yMd().format(end)}'
            }).whenComplete(() {
              print('Customer Added');
            }).then((_) {
              Navigator.pop(context);
            });
          }
        },
        icon: Icon(Icons.save),
        label: (widget.customer.id != null) ? Text('Update') : Text('Add'),
        elevation: 50.0,
      ),
    );
  }
}

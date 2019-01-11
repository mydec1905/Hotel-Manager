import 'package:flutter/material.dart';
import 'package:hotel_manager/model.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hotel_manager/database_helper.dart';

class Input extends StatefulWidget {
  final List<Customer> infotemp;
  final int index;

  Input({Key key, this.infotemp, this.index}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InputState();
  }
}

class InputState extends State<Input> {
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
              validator: (val)=>val.length==0?"Enter Name":null,
              onSaved: (val)=>this.name = val,
            ),
            TextFormField(
              controller: phonecontroller,
              autofocus: false,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Input Phone Number', icon: Icon(Icons.phone)),
              validator: (val)=>val.length==0?"Enter Phone Number":null,
              onSaved: (val)=>this.phone = val,
            ),
            TextFormField(
              controller: paidcontroller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'PrePaid', icon: Icon(Icons.attach_money)),
              validator: (val)=>val.length==0?"Enter Money":null,
              onSaved: (val)=>this.paid= val,
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
          Customer temp = new Customer(
            namecontroller.text,
            phonecontroller.text,
            paidcontroller.text,
            DateFormat.yMd().format(start),
            DateFormat.yMd().format(end),
          );
          var dbHelper = DBHelper();
          dbHelper.saveCustomer(temp);

          widget.infotemp.add(temp);
          if (widget.infotemp.length > 1) {
            widget.infotemp.sort((date, date2) {
              return date.datestart.compareTo(date2.datestart);
            });
          }
          _submit();

          Navigator.of(context).pop();
        },
        icon: Icon(Icons.save),
        label: Text('Save'),
        elevation: 50.0,
      ),
    );
  }

  void _submit() {
    if (this.formKey.currentState.validate()) {
      formKey.currentState.save();
    }
    var customer = Customer(name,phone,paid,dateStart,dateEnd);
    var dbHelper = DBHelper();
    dbHelper.saveCustomer(customer);
    _showSnackBar("Data saved successfully");
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }
}

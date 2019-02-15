import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hotel_manager/model.dart';
import 'package:hotel_manager/screen/hotel1/edit.dart';
import 'package:hotel_manager/screen/hotel1/input1.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Hotel1 extends StatefulWidget {
  final List<Customer> info1;
  Hotel1({Key key, this.info1}) : super(key: key);



  @override
  _Hotel1State createState() => _Hotel1State();
}
final hotelReference = FirebaseDatabase.instance.reference().child('hotel1');
class _Hotel1State extends State<Hotel1> {
  StreamSubscription<Event> customerAddedSubscription;
  StreamSubscription<Event> customerChangedSubscription;
  final dateFormat = DateFormat.yMd();
  @override
  void initState() {

customerAddedSubscription = hotelReference.onChildAdded.listen(customerAdded);
customerChangedSubscription = hotelReference.onChildChanged.listen(customerUpdated);
    super.initState();
  }
  @override
  void dispose() {
    customerAddedSubscription.cancel();
    customerChangedSubscription.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: widget.info1?.length ?? 0,
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
                      child: Text('${widget.info1[index].name}'),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text('${widget.info1[index].datestart}'),
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
                                    '''Name : ${widget.info1[index].name}\nPhone: ${widget.info1[index].phone}\nPrepaid: ${widget.info1[index].paid} VND\nStart: ${widget.info1[index].datestart}\nEnd :  ${widget.info1[index].dateend}
                              ''')),
                            IconButton(
                                icon: Icon(Icons.phone),
                                onPressed: () =>
                                    launch("tel:${widget.info1[index].phone}")),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                editCustomer(context, widget.info1[index]);
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
                                                deleteCustomer(context,widget.info1[index],index);
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
        onPressed: ()=>createNewCustomer(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void deleteCustomer(BuildContext context,Customer customer,int index) async{

    await hotelReference.child(customer.id).remove().then((_){
      setState(() {
        widget.info1.removeAt(index);
      });
    });

  }
  void customerAdded(Event event){
    setState(() {
      widget.info1.add(Customer.fromSnapshot(event.snapshot));
    });
  }
  void customerUpdated(Event event){
    var customerValue = widget.info1.singleWhere((customer)=> customer.id == event.snapshot.key);
    setState(() {
      widget.info1[widget.info1.indexOf(customerValue)]= Customer.fromSnapshot(event.snapshot);
    });
  }
  void createNewCustomer(BuildContext context)async{
    await Navigator.push(context, MaterialPageRoute(builder: (context)=>Input(Customer(null, '', '', '', '', ''))));
  }
  void editCustomer(BuildContext context, Customer customer)async{
    await Navigator.push(context, MaterialPageRoute(builder: (context)=>Input(customer)));
  }


}



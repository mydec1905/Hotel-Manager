import 'package:firebase_database/firebase_database.dart';

class Customer {
  String id;
  String name;
  String phone;
  String paid;
  String datestart;
  String dateend;

  Customer(this.id,this.name, this.phone, this.paid, this.datestart, this.dateend);

  Customer.fromSnapshot(DataSnapshot snapshot){
    id = snapshot.key;
    name = snapshot.value['name'];
    phone = snapshot.value['phone'];
    paid = snapshot.value['paid'];
    datestart = snapshot.value['start'];
    dateend = snapshot.value['end'];


  }
}

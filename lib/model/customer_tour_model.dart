import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerTour {
  String name;
  String phone;
  String quality;
  String location;
  String tour;
  String date;
  String keyword;
  DocumentReference reference;

  CustomerTour.fromMap(Map<dynamic, dynamic> data,{this.reference})
      : name = data['name'],
        phone = data['phone'],
        quality = data['quality'],
        location = data['location'],
        tour = data['tour'],
        date = data['date'],
        keyword = data['keyword'];

  CustomerTour.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference : snapshot.reference);
}

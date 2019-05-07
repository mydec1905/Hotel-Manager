import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_manager/screens/tours_booking/toursbooking.dart';
class StreamData{

  static final streamDefault  = Firestore.instance.collection('TOUR_BOOKING_LIST').orderBy('time',descending: true).snapshots();
  static final streamDataEdit = Firestore.instance.collection('TOUR_BOOKING_LIST').document().snapshots();
  static final nhaTrang =  Firestore.instance.collection('TOUR_BOOKING_LIST').where('location',isEqualTo: 'Nha Trang').snapshots();
  static final phuQuoc =  Firestore.instance.collection('TOUR_BOOKING_LIST').where('location',isEqualTo: 'Phu Quoc').snapshots();

 static getDateFilter(){
    final filterByDate = Firestore.instance.collection('TOUR_BOOKING_LIST').where('date',isEqualTo: dateSelected).snapshots();
    return filterByDate;
}

}
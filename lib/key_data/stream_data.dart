import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_manager/screens/hotel_screen/hotelsbooking.dart';
import 'package:hotel_manager/screens/tracking/tours_tracking.dart';
class StreamData{

  static final streamDefault  = Firestore.instance.collection('TOUR_BOOKING_LIST').orderBy('time',descending: true).snapshots();
  static final streamDataEdit = Firestore.instance.collection('TOUR_BOOKING_LIST').document().snapshots();
  static final nhaTrang =  Firestore.instance.collection('TOUR_BOOKING_LIST').where('location',isEqualTo: 'Nha Trang').snapshots();
  static final phuQuoc =  Firestore.instance.collection('TOUR_BOOKING_LIST').where('location',isEqualTo: 'Phu Quoc').snapshots();
  static final hoiAn =  Firestore.instance.collection('TOUR_BOOKING_LIST').where('location',isEqualTo: 'Hoi An').snapshots();
  static final locationList =  Firestore.instance.collection('TOURS_DETAIL').snapshots();
  static final streamTrackingPhuQuoc = Firestore.instance.collection('Phu Quoc').snapshots();
  static final streamTrackingNhaTrang = Firestore.instance.collection('Nha Trang').snapshots();





  static final streamHotelDefault = Firestore.instance.collection('HOTEL_BOOKING_LIST').orderBy('time',descending: true).snapshots();


 static getDateFilter(){
    final filterByDate = Firestore.instance.collection('TOUR_BOOKING_LIST').where('date',isEqualTo: dateSelected).snapshots();
    return filterByDate;
}



}
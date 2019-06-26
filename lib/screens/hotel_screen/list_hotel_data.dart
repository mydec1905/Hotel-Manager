import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_manager/key_data/stream_data.dart';
import 'package:hotel_manager/theme/color.dart';
import 'package:hotel_manager/theme/text_style.dart';
import 'package:hotel_manager/widgets/loading_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/cupertino.dart';
import 'package:date_format/date_format.dart';

var streamDataHotel = StreamData.streamHotelDefault;

class ListHotelContent extends StatefulWidget {
  final Animation<double> listTileWidth;
  final Animation<Alignment> listSlideAnimation;
  final Animation<EdgeInsets> listSlidePosition;

  ListHotelContent({
    this.listSlideAnimation,
    this.listSlidePosition,
    this.listTileWidth,
  });

  @override
  _ListHotelContentState createState() => _ListHotelContentState();
}

class _ListHotelContentState extends State<ListHotelContent> {




  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: StreamData.streamHotelDefault,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return LoadingIndicator();
            default:
              return Container(
                height: MediaQuery.of(context).size.height / 1.7,
                child: Scrollbar(
                  child: ListView(
                    padding: EdgeInsets.all(0.0),
                    children: snapshot.data.documents
                        .map((DocumentSnapshot document) {
                      return _data(context, document);
                    }).toList(),
                  ),
                ),
              );
          }
        });
  }

  Widget _data(BuildContext context, DocumentSnapshot snapshot) {
    final data = HotelData.fromSnapshot(snapshot);



     return Slidable(

        delegate: SlidableDrawerDelegate(),
        actionExtentRatio: 0.25,
        actions: <Widget>[
          IconSlideAction(
            onTap: () {
              print(data.phone);
              launch("tel://${data.phone}");
            },
            icon: Icons.phone,
            color: Colors.transparent,
            caption: 'Call',
            foregroundColor: AppColors.primary,
          )
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
            icon: Icons.edit,
            color: Colors.transparent,
            caption: 'Edit',
            foregroundColor: AppColors.primary,
          ),
          IconSlideAction(
            onTap: () {
              //function();
              Firestore.instance.collection('HOTEL_BOOKING_LIST').document(snapshot.documentID).delete();
            },
            icon: Icons.delete,
            color: Colors.transparent,
            caption: 'Delete',
            foregroundColor: AppColors.primary,
          )
        ],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.cardColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: ExpansionTile(

                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(data.name, style: headingText),
                    Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text(data.hotel, style: subText),
                    )
                  ],
                ),
                leading: Container(
                    child: Center(
                      child: Text(
                        data.checkIn.substring(0, 5),
                        style: calendarText,
                      ),
                    ),
                    // margin: EdgeInsets.only(
                    //     left: 10.0, top: 10.0, bottom: 10.0, right: 10.0),
                    width: 60.0,
                    //height: 60.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.primary,
                    )),
                trailing: Container(
                    child: Center(
                      child: Text(
                        data.checkOut.substring(0, 5),
                        style: calendarText,
                      ),
                    ),
                    // margin: EdgeInsets.only(
                    //     left: 10.0, top: 10.0, bottom: 10.0, right: 10.0),
                    width: 60.0,
                    //  height: 60.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.primary,
                    )),
                children: _buildRoomItem(context, snapshot, data.room.length)
              )),
          //),
        ),
      );

  }

  List<Widget> roomList = List<Widget>();

//  _buildList(BuildContext context, DocumentSnapshot snapshot) {
//    final data = HotelData.fromSnapshot(snapshot);
//     var length = data.room.length;
//    for (int i = 0; i < length; i++) {
//      roomList.add( _buildRoomItem(context, snapshot, i));
//    }
//    print(roomList.length);
//    return roomList;
//  }
  




  _buildRoomItem(BuildContext context, DocumentSnapshot snapshot, int index) {
    List<Widget> roomList = [];
    final data = HotelData.fromSnapshot(snapshot);

    for(int i = 0; i<index;i++){
       var _container =  Container(
          child: Row(
            children: <Widget>[
              Expanded(flex:7,child: Center(child: Text('${data.room[i].room} :',style: headingText,))),
              Expanded(flex:3,child: Center(child: Text(data.room[i].quality,style: headingText,)))
            ],
          ),
        );
         roomList.add(_container);
        }
    return roomList;
  }
}

class HotelData {
  final String name;
  final String phone;
  final String hotel;
  final String checkIn;
  final String checkOut;
  final List<Room> room;

  HotelData.fromMap(Map<dynamic, dynamic> data)
      : name = data['name'],
        phone = data['phone'],
        hotel = data['hotel'],
        checkIn = data['check_in'],
        checkOut = data['check_out'],
        room = (data['room'] as List).map((i) {
          return Room.fromMap(i);
        }).toList();

  HotelData.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data);
}

class Room {
  final String room;
  final String quality;

  Room.fromMap(Map<dynamic, dynamic> data)
      : room = data['title'],
        quality = data['quality'];
}

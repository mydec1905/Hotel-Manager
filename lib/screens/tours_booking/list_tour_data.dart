import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_manager/screens/components/loading_indicator.dart';
import 'package:hotel_manager/key_data/stream_data.dart';
import 'package:hotel_manager/theme/color.dart';
import 'package:hotel_manager/theme/text_style.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/cupertino.dart';
import 'package:date_format/date_format.dart';

var streamDataTour = StreamData.streamDefault;

class ListTourContent extends StatelessWidget {
  final Animation<double> listTileWidth;
  final Animation<Alignment> listSlideAnimation;
  final Animation<EdgeInsets> listSlidePosition;

  ListTourContent({
    this.listSlideAnimation,
    this.listSlidePosition,
    this.listTileWidth,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: streamDataTour,
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
                      return TourData(
                        width: listTileWidth.value,
                        name: document['name'],
                        tour: document['tour'],
                        phone: document['phone'],
                        date: document['date'],
                        function: () {
                          Firestore.instance
                              .collection('TOUR_BOOKING_LIST')
                              .document(document.documentID)
                              .delete();
                          Scaffold.of(context)
                              .showSnackBar(SnackBar(content: Text('Deleted')));
                        },
                      );
                    }).toList(),
                  ),
                ),
              );
          }
        });
  }
}

class TourData extends StatelessWidget {
  final double width;
  final String name;
  final String tour;
  final String phone;
  final String date;
  final Function function;

  TourData(
      {this.name, this.phone, this.tour, this.width, this.date, this.function});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      delegate: SlidableDrawerDelegate(),
      actionExtentRatio: 0.25,
      actions: <Widget>[
        IconSlideAction(
          onTap: () {
            print(phone);
            launch("tel://$phone");
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
            function();
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
          width: width,
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: <Widget>[
              Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          date.substring(0, 2),
                          style: calendarText,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 4.0, left: 4.0),
                          child: Divider(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          formatDate(
                              DateTime(
                                  0, int.parse(date.substring(3, 5)) + 1, 0),
                              [M])
                          //date.substring(3, 5)
                          ,
                          style: calendarText,
                        )
                      ],
                    ),
                  ),
                  margin: EdgeInsets.only(
                      left: 20.0, top: 10.0, bottom: 10.0, right: 20.0),
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.primary,
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        name,
                        style:
                        headingText
                      ),
                      Text('  -  '),
                      Text(
                        phone,
                        style: headingText
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Text(
                      tour,
                      style: subText
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        //),
      ),
    );
  }
}

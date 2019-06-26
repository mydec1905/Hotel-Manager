import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_manager/theme/color.dart';
import 'package:hotel_manager/widgets/loading_indicator.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TourProgress extends StatefulWidget {
  @override
  _TourProgressState createState() => _TourProgressState();
}

class _TourProgressState extends State<TourProgress> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('Nha Trang').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return LoadingIndicator();
        return ListView(
            children: snapshot.data.documents.map((DocumentSnapshot document) {
          return _ToursTrackingCard(
            icon: Icons.card_travel,
            iconBackgroundColor: AppColors.primary,
            title: document['title'],
            timeUpdate: document['time_update'],
            bookCount: document['book_count'],
          );
        }).toList());
      },
    );
  }
}

class _ToursTrackingCard extends StatelessWidget {
  final IconData icon;
  final Color iconBackgroundColor;
  final String title;
  final String timeUpdate;
  final int bookCount;


  _ToursTrackingCard(
      {this.icon,
      this.iconBackgroundColor,
      this.title,
      this.timeUpdate,
      this.bookCount,
    });

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
        child: new Card(
          elevation: 10.0,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: new Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: new BoxDecoration(
                    color: iconBackgroundColor,
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(15.0)),
                  ),
                  child: new Icon(
                    icon,
                    color: Colors.white,
                  ),
                ),
              ),
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Text(
                      title,
                      style: const TextStyle(
                        fontSize: 25.0,
                        fontFamily: 'mermaid',
                      ),
                    ),
                    new Text(
                      'Last Updated : ${DateFormat('dd-MM-yyyy').format(DateTime.parse(timeUpdate))}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'bebas-neue',
                        letterSpacing: 1.0,
                        color: const Color(0xFFAAAAAA),
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                width: 2.0,
                height: 70.0,
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.white,
                      const Color(0xFFAAAAAA),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: new Column(
                  children: [
                    new Icon(
                      Icons.card_travel,
                      color: Colors.red,
                    ),
                    new Text(
                      '$bookCount',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

    );
  }
}

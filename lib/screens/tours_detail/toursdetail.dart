import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hotel_manager/screens/menu/animate_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_manager/screens/components/loading_indicator.dart';
import 'package:hotel_manager/theme/color.dart';
import 'package:webview_flutter/webview_flutter.dart';

final Screen toursDetails = new Screen(
    title: 'TOURS DETAILS',
    background: new DecorationImage(
      image: new AssetImage('assets/Sea_and_sky_light.jpg'),
      fit: BoxFit.cover,
    ),
    contentBuilder: (BuildContext context) {
      return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('TOURS_DETAIL').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return LoadingIndicator();
          return ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
            return _ToursDetailCard(
              icon: Icons.card_travel,
              iconBackgroundColor: AppColors.primary,
              title: document['title'],
              subtitle: document['subtitle'],
              headImageAssetPath: document['image'],
              bookCount: document['book_count'],
            );
          }).toList());
        },
      );
    });

class _ToursDetailCard extends StatelessWidget {
  final String headImageAssetPath;
  final IconData icon;
  final Color iconBackgroundColor;
  final String title;
  final String subtitle;
  final int bookCount;
  final String url;

  _ToursDetailCard(
      {this.headImageAssetPath,
      this.icon,
      this.iconBackgroundColor,
      this.title,
      this.subtitle,
      this.bookCount,
      this.url});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(url);
      },
      child: new Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
        child: new Card(
          elevation: 10.0,
          child: new Column(
            children: [
              new Image.network(
                headImageAssetPath,
                width: double.infinity,
                height: 150.0,
                fit: BoxFit.cover,
              ),
              new Row(
                children: [
                  new Padding(
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
                          subtitle,
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
            ],
          ),
        ),
      ),
    );
  }
}

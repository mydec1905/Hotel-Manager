import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_manager/screens/components/loading_indicator.dart';
import 'package:hotel_manager/screens/components/stream_data.dart';
import 'package:hotel_manager/theme/color.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/cupertino.dart';
var streamDataTour = StreamData.streamDefault;
class ListViewContent extends StatelessWidget {
  final Animation<double> listTileWidth;
  final Animation<Alignment> listSlideAnimation;
  final Animation<EdgeInsets> listSlidePosition;

  ListViewContent({
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
                  child:  ListView(
                    padding: EdgeInsets.all(0.0),
                    children:
                    snapshot.data.documents
                        .map((DocumentSnapshot document) {
                      return
                        Data(
                           width: listTileWidth.value,
                          name: document['name'],
                          tour: document['tour'],
                          phone: document['phone'],
                          keyword: document['key'],
                          function: (){
                             Firestore.instance.collection('TOUR_BOOKING_LIST').document(document.documentID).delete();
                             Scaffold.of(context).showSnackBar(SnackBar(content: Text('Deleted')));
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

class Data extends StatelessWidget {
  final double width;
  final String name;
  final String tour;
  final String phone;
  final String keyword;
  final Function function;

  Data({this.name, this.phone, this.tour, this.width, this.keyword,this.function});
  @override
  Widget build(BuildContext context) {
    return
      Slidable(
        delegate: SlidableDrawerDelegate(),
        actionExtentRatio: 0.25,
        actions: <Widget>[
          IconSlideAction(
            onTap: ()  {
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
            onTap: (){
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
                      child: Text(
                        keyword,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    margin: EdgeInsets.only(
                        left: 20.0, top: 10.0, bottom: 10.0, right: 20.0),
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          name,
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w400),
                        ),
                        Text('  -  '),
                        Text(
                          phone,
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text(
                        tour,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w300),
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

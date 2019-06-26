import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:hotel_manager/theme/text_style.dart';
import 'package:hotel_manager/widgets/loading_indicator.dart';

class TourChart extends StatefulWidget {
  @override
  _TourChartState createState() => _TourChartState();
}

class _TourChartState extends State<TourChart> {
  List<CircularSegmentEntry> list = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('Nha Trang').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return LoadingIndicator();
          else {
            for (int i = 0; i < snapshot.data.documents.length; i++) {
              DocumentSnapshot snap = snapshot.data.documents[i];

              list.add(CircularSegmentEntry(
                  double.parse(snap.data['book_count'].toString())

                  //snap.data['book_count'] * 100 / total
                  ,
                  Color(int.parse(snap.data['color']))));
            }
          }
          return Material(
              color: Colors.transparent,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      //elevation: 10,

                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                flex: 2,
                                child: AnimatedCircularChart(
                                    size: Size(150, 150),
                                    percentageValues: false,
                                    chartType: CircularChartType.Pie,
                                    initialChartData: <CircularStackEntry>[
                                      CircularStackEntry(list)
                                    ])),
                            Expanded(
                                flex: 1,
                                child:
                                    hintList(context, snapshot.data.documents)),
                          ],
                        ),
                        height: 200,
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          elevation: 10,
                          child: Container(
                            height: 200,
                          ),
                        ),
                      )),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Container(
                            height: 200,
                          ),
                        ),
                      )),
                    ],
                  )
                ],
              ));
        });
  }

  Widget hintList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      children: snapshot.map((data) => hint(context, data)).toList(),
    );
  }

  Widget hint(BuildContext context, DocumentSnapshot snapshot) {
    final data = Hint.fromSnapshot(snapshot);
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: <Widget>[
            Container(
              height: 20,
              width: 20,
              color: Color(int.parse(data.color)),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                data.title,
                style: textChart,
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class Hint {
  final String color;
  final String title;

  Hint.fromMap(Map<String, dynamic> data)
      : color = data['color'],
        title = data['title'];

  Hint.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data);
}

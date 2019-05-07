import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
class TourChart extends StatefulWidget {
  @override
  _TourChartState createState() => _TourChartState();
}

class _TourChartState extends State<TourChart> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListView(
        children: <Widget>[
          Card(child: Text('chart'),),
          Row(children: <Widget>[

          ],)
        ],
      )

    );
  }
}

import 'package:flutter/material.dart';

class Calender extends StatelessWidget {
  final EdgeInsets margin;
  final List<String> week = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"];
  final List arrayDay = [];
  Calender({this.margin});

  int totaldays(int month) {
    if (month == 2)
      return (28);
    else if (month == 4 || month == 6 || month == 9 || month == 11)
      return (30);
    else
      return (31);
  }

  @override
  Widget build(BuildContext context) {
    int element = new DateTime.now().day - new DateTime.now().weekday;
    int totalDay = totaldays(new DateTime.now().month);
    for (var i = 0; i < 7; i++) {
      if (element > totalDay) element = 1;
      arrayDay.add(element);
      element++;
    }
    var i = -1;
    return (new Container(
      margin: margin,
      alignment: Alignment.center,
      padding: new EdgeInsets.only(top: 20.0),
      decoration: new BoxDecoration(
        color: Colors.transparent,
        border: new Border(
          bottom: new BorderSide(
              width: 1.0, color: const Color.fromRGBO(204, 204, 204, 0.5)),
        ),
      ),
      child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: week.map((String week) {
            ++i;
            return new CalenderCell(
                week: week,
                day: arrayDay[i].toString(),
                today: arrayDay[i] != new DateTime.now().day ? false : true);
          }).toList()),
    ));
  }
}
class CalenderCell extends StatelessWidget {
  final String week;
  final String day;
  final bool today;
  CalenderCell({this.week, this.day, this.today});
  @override
  Widget build(BuildContext context) {
    return (new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Text(
          week,
          style: new TextStyle(
              color: Color.fromRGBO(247, 64, 106, 1.0),
              fontSize: 12.0,
              fontWeight: FontWeight.w400),
        ),
        new Padding(
          padding: new EdgeInsets.only(top: 10.0, bottom: 5.0),
          child: new Container(
              width: 35.0,
              height: 35.0,
              alignment: Alignment.center,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color: today
                      ? const Color.fromRGBO(204, 204, 204, 0.3)
                      : Colors.transparent),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    day,
                    style: new TextStyle(
                        fontSize: 12.0, fontWeight: FontWeight.w400),
                  ),
                  today
                      ? new Container(
                    padding: new EdgeInsets.only(top: 3.0),
                    width: 3.0,
                    height: 3.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color.fromRGBO(247, 64, 106, 1.0)),
                  )
                      : new Container()
                ],
              )),
        )
      ],
    ));
  }
}
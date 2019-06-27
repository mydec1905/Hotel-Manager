import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hotel_manager/constants/constants.dart';
import 'package:hotel_manager/key_data/stream_data.dart';
import 'package:hotel_manager/localization/flutter_localizations.dart';
import 'package:hotel_manager/screens/main_screen/animate_menu.dart';
import 'package:hotel_manager/theme/color.dart';
import 'package:hotel_manager/theme/image.dart';
import 'package:hotel_manager/widgets/button.dart';
import 'package:hotel_manager/widgets/calendar.dart';
import 'package:hotel_manager/widgets/fade_box.dart';
import 'package:intl/intl.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/foundation.dart';

import 'add_tours_booking.dart';
import 'package:hotel_manager/widgets/animation.dart';
import 'list_tour_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

DateTime now = DateTime.now();
var _date = DateTime.now().day;
var _month = DateTime.now().month;
var _year = DateTime.now().year;
String dateSelected = DateFormat('dd-MM-yyyy').format(now);


final Screen toursBooking = new Screen(
    title: Constants.idTourScreen.toUpperCase(),
    background: new DecorationImage(
      image: new AssetImage(Images.background),
      fit: BoxFit.cover,
    ),
    contentBuilder: (BuildContext context) {
      return TourScreen();
    });




class TourScreen extends StatefulWidget {
  const TourScreen({Key key}) : super(key: key);

  @override
  TourScreenState createState() => new TourScreenState();
}

class TourScreenState extends State<TourScreen> with TickerProviderStateMixin {
  Animation<double> containerGrowAnimation;
  AnimationController _screenController;
  AnimationController _buttonController;
  Animation<double> buttonGrowAnimation;
  Animation<double> listTileWidth;
  Animation<Alignment> listSlideAnimation;
  Animation<Alignment> buttonSwingAnimation;
  Animation<EdgeInsets> listSlidePosition;
  Animation<Color> fadeScreenAnimation;
  var animateStatus = 0;
  String month = new DateFormat.MMMM().format(
    new DateTime.now(),
  );
  int index = new DateTime.now().month;

  @override
  void initState() {
    super.initState();

    _screenController = new AnimationController(
        duration: new Duration(milliseconds: 2000), vsync: this);
    _buttonController = new AnimationController(
        duration: new Duration(milliseconds: 1500), vsync: this);

    fadeScreenAnimation = new ColorTween(
      begin: const Color.fromRGBO(247, 64, 106, 1.0),
      end: const Color.fromRGBO(247, 64, 106, 0.0),
    ).animate(
      new CurvedAnimation(
        parent: _screenController,
        curve: Curves.ease,
      ),
    );
    containerGrowAnimation = new CurvedAnimation(
      parent: _screenController,
      curve: Curves.easeIn,
    );

    buttonGrowAnimation = new CurvedAnimation(
      parent: _screenController,
      curve: Curves.easeOut,
    );
    containerGrowAnimation.addListener(() {
      this.setState(() {});
    });
    containerGrowAnimation.addStatusListener((AnimationStatus status) {});

    listTileWidth = new Tween<double>(
      begin: 1000.0,
      end: 600.0,
    ).animate(
      new CurvedAnimation(
        parent: _screenController,
        curve: new Interval(
          0.225,
          0.600,
          curve: Curves.bounceIn,
        ),
      ),
    );

    listSlideAnimation = new AlignmentTween(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).animate(
      new CurvedAnimation(
        parent: _screenController,
        curve: new Interval(
          0.325,
          0.700,
          curve: Curves.ease,
        ),
      ),
    );
    buttonSwingAnimation = new AlignmentTween(
      begin: Alignment.topCenter,
      end: Alignment.bottomRight,
    ).animate(
      new CurvedAnimation(
        parent: _screenController,
        curve: new Interval(
          0.225,
          0.600,
          curve: Curves.ease,
        ),
      ),
    );
    listSlidePosition = new EdgeInsetsTween(
      begin: const EdgeInsets.only(bottom: 16.0),
      end: const EdgeInsets.only(bottom: 80.0),
    ).animate(
      new CurvedAnimation(
        parent: _screenController,
        curve: new Interval(
          0.325,
          0.800,
          curve: Curves.ease,
        ),
      ),
    );
    _screenController.forward();
  }

  @override
  void dispose() {
    _screenController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  Future<Null> _playAnimation() async {
    try {
      await _buttonController.forward();
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.3;
    Size screenSize = MediaQuery.of(context).size;

    return (new WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: new Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: new Container(
          decoration: BoxDecoration(color: Colors.transparent),
          width: screenSize.width,
          height: screenSize.height,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              ListView(
                children: <Widget>[
                  Calender(),
                  ListTourContent(
                      listSlideAnimation: listSlideAnimation,
                      listSlidePosition: listSlidePosition,
                      listTileWidth: listTileWidth)
                ],
              ),
              FadeBox(
                fadeScreenAnimation: fadeScreenAnimation,
                containerGrowAnimation: containerGrowAnimation,
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.cardColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: animateStatus == 0
                    ? Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InkWell(
                                splashColor: Colors.white,
                                highlightColor: Colors.white,
                                onTap: () {
                                  setState(() {
                                    animateStatus = 1;
                                  });
                                  _playAnimation();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Button(
                                    icon: Icons.calendar_today,
                                    buttonGrowAnimation: buttonGrowAnimation,
                                    function: () {


                                      DatePicker.showDatePicker(
                                        context,
                                        showTitleActions: true,
                                        locale: 'en',
                                        minYear: 1970,
                                        maxYear: 2020,
                                        cancel: Text(FlutterLocalizations.of(context).getString('cancel')),
                                        confirm: Text(FlutterLocalizations.of(context).getString('confirm')),
                                        dateFormat: 'dd-mm-yyyy',
                                        onChanged: (year, month, date) {
                                          setState(() {
                                            _date = date;
                                            _month = month;
                                            _year = year;

                                            if (date < 10) {
                                              if (month < 10) {
                                                dateSelected =
                                                    '${_date.toString().padLeft(2, '0')}-${_month.toString().padLeft(2, '0')}-$_year';

                                              } else {
                                                dateSelected =
                                                    '${_date.toString().padLeft(2, '0')}-$_month-$_year';
                                              }
                                            } else {
                                              if (month < 10) {
                                                dateSelected =
                                                    '$_date-${_month.toString().padLeft(2, '0')}-$_year';
                                              } else {
                                                dateSelected =
                                                    '$_date-$_month-$_year';
                                              }
                                            }
                                          });
                                          print('------>$dateSelected');
                                        },
                                        onConfirm: (year, month, date) {

                                          setState(() {

                                            streamDataTour = StreamData.getDateFilter();

                                            dateSelected = DateFormat('dd-MM-yyyy').format(now);
                                            print('--> $dateSelected');

                                          });

                                        },
                                        onCancel: () {
                                          setState(() {
                                            streamDataTour = StreamData.streamDefault;
                                            _date = DateTime.now().day;
                                            _month = DateTime.now().month;
                                            _year = DateTime.now().year;
                                          });
                                        },
                                      );
                                    },
                                  ),
                                )),
                            InkWell(
                                splashColor: Colors.white,
                                highlightColor: Colors.white,
                                onTap: () {
                                  setState(() {
                                    animateStatus = 1;
                                  });
                                  _playAnimation();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Button(
                                    icon: Icons.add,
                                    buttonGrowAnimation: buttonGrowAnimation,
                                    function: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  AddCustomer()));
                                    },
                                  ),
                                )),
                            InkWell(
                                splashColor: Colors.white,
                                highlightColor: Colors.white,
                                onTap: () {
                                  setState(() {
                                    animateStatus = 1;
                                  });
                                  _playAnimation();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Button(
                                    icon: Icons.location_on,
                                    buttonGrowAnimation: buttonGrowAnimation,
                                    function: () {
                                      showCupertinoModalPopup(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return CupertinoActionSheet(
                                              title: Text(FlutterLocalizations.of(context).getString('filter').toUpperCase()),
                                              cancelButton:
                                                  CupertinoActionSheetAction(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(FlutterLocalizations.of(context).getString('cancel').toUpperCase())),
                                              message: Text(
                                                  'Choose your filter option'),
                                              actions: <Widget>[
                                                CupertinoActionSheetAction(
                                                    child: Text('Get All'),
                                                    onPressed: () {
                                                      setState(() {
                                                        streamDataTour =
                                                            StreamData
                                                                .streamDefault;
                                                        Navigator.pop(context);
                                                      });
                                                    }),
                                                CupertinoActionSheetAction(
                                                    child: Text('Phu Quoc'),
                                                    onPressed: () {
                                                      setState(() {
                                                        streamDataTour =
                                                            StreamData.phuQuoc;
                                                        Navigator.pop(context);
                                                      });
                                                    }),
                                                CupertinoActionSheetAction(
                                                    child: Text('Nha Trang'),
                                                    onPressed: () {
                                                      setState(() {
                                                        streamDataTour =
                                                            StreamData.nhaTrang;
                                                        Navigator.pop(context);
                                                      });
                                                    }),
                                                CupertinoActionSheetAction(
                                                  child: Text('Phu Yen'),
                                                  onPressed: () =>
                                                      print('Phu Yen'),
                                                ),
                                                CupertinoActionSheetAction(
                                                  child: Text('Da Nang'),
                                                  onPressed: () =>
                                                      print('Da Nang'),
                                                ),
                                                CupertinoActionSheetAction(
                                                  child: Text('Hoi An'),
                                                  onPressed: () =>
                                                      setState(() {
                                                        streamDataTour =
                                                            StreamData.hoiAn;
                                                        Navigator.pop(context);
                                                      })
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                  ),
                                )),
                          ],
                        ))
                    : StaggerAnimation(
                        buttonController: _buttonController.view),
              ),
            ],
          ),
        ),
      ),
    ));
  }

}

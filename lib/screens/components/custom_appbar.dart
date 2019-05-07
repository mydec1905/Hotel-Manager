import 'package:flutter/material.dart';
class CustomAppBar extends StatelessWidget {
  final Icon icon;
  final Function iconFunction;
  final String title;
  final double height;
  CustomAppBar({this.icon,this.iconFunction,this.title,this.height});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: ListTile(
        leading: IconButton(icon: icon, onPressed: (){
          iconFunction();
        }),
        title: Text(title, style: new TextStyle(
          fontFamily: 'bebas-neue',
          fontSize: 25.0,
        ),),
      ),
    );
  }
}

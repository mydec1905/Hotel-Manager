import 'package:flutter/material.dart';
import 'package:hotel_manager/theme/color.dart';

class Button extends StatelessWidget {
  final Animation<double> buttonGrowAnimation;
  final IconData icon;
  final Function function;
  Button({this.buttonGrowAnimation,this.function,this.icon});
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: function,
      child: Container(
        width: buttonGrowAnimation.value * 60,
        height: buttonGrowAnimation.value * 60,
        alignment: FractionalOffset.center,
        decoration: new BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle),
          child:  Icon(
            icon,
            size: buttonGrowAnimation.value * 40.0,
            color: Colors.white,
          ),

      ),
    );
  }
}
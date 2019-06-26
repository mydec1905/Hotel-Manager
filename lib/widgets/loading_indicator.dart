import 'package:flutter/material.dart';
import 'package:hotel_manager/theme/color.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: AppColors.primary,
        ),
      ),
    );
  }
}

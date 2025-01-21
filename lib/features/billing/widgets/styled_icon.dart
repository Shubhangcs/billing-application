import 'package:flutter/material.dart';
import 'package:new_billing/core/themes/colors.dart';

class StyledIcon extends StatelessWidget {
  final IconData icon;
  const StyledIcon({super.key , required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: AppColors.lightGrey,
          width: 2,
        ),
      ),
      child: Icon(
        icon,
        size: 30,
        color: AppColors.black,
      ),
    );
  }
}

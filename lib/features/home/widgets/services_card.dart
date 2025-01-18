import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_billing/core/themes/colors.dart';

class ServicesCard extends StatelessWidget {
  final String cardTitle;
  final IconData leading;
  final IconData trailing;
  const ServicesCard({super.key , required this.cardTitle , required this.leading , required this.trailing});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Card(
        surfaceTintColor: AppColors.white,
        color: AppColors.white,
        elevation: 3,
        child: Center(
          child: ListTile(
            leading: Icon(
              leading,
              size: 30,
            ),
            title: Text(
              cardTitle,
              style: GoogleFonts.poppins(
                color: AppColors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Icon(
              trailing,
              size: 30,
              color: AppColors.black,
            ),
          ),
        ),
      ),
    );
  }
}

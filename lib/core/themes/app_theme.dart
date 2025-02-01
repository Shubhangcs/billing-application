import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_billing/core/themes/colors.dart';

class AppTheme {
  static OutlineInputBorder borderDecoration(
      [Color color = AppColors.lightGrey, double width = 1.5]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        width: width,
        color: color,
      ),
    );
  }

  static ThemeData lightTheme = ThemeData.light(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: AppColors.lightestGrey,
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
          color: AppColors.blue,
          size: 30,
        ),
        titleSpacing: 1,
        titleTextStyle: GoogleFonts.poppins(
          color: AppColors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: AppColors.lightestGrey,
        surfaceTintColor: AppColors.lightestGrey,
        elevation: 0,
        shadowColor: AppColors.transperent),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: borderDecoration(),
      disabledBorder: borderDecoration(),
      focusedBorder: borderDecoration(AppColors.blue, 2.5),
      errorBorder: borderDecoration(),
      border: borderDecoration(),
      focusedErrorBorder: borderDecoration(),
      hintStyle: GoogleFonts.poppins(
        color: AppColors.grey,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: WidgetStatePropertyAll(0),
        backgroundColor: WidgetStatePropertyAll(AppColors.blue),
        textStyle: WidgetStatePropertyAll(
          GoogleFonts.poppins(
            color: AppColors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}

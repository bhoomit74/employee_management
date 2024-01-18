import 'package:employee_management/core/styles/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle get hintTextStyle => TextStyle(
      color: AppColors.hintColor,
      fontSize: 16,
      fontFamily: GoogleFonts.roboto().fontFamily);

  static TextStyle body({Color color = AppColors.black}) => TextStyle(
      fontSize: 18, color: color, fontFamily: GoogleFonts.roboto().fontFamily);

  static TextStyle bodyMedium({Color color = AppColors.black}) => TextStyle(
      fontSize: 18,
      color: color,
      fontFamily: GoogleFonts.roboto(fontWeight: FontWeight.w500).fontFamily);

  static TextStyle bodyBold({Color color = AppColors.black}) => TextStyle(
      fontSize: 18,
      color: color,
      fontFamily: GoogleFonts.roboto(fontWeight: FontWeight.bold).fontFamily);
}

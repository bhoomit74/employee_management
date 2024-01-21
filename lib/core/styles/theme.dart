import 'package:employee_management/core/styles/app_colors.dart';
import 'package:employee_management/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static DatePickerThemeData get datePickerTheme => DatePickerThemeData(
      dayStyle: AppTextStyles.bodySmall(),
      todayBorder: const BorderSide(color: AppColors.primary, width: 1));
}

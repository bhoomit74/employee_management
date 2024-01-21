import 'package:employee_management/core/styles/app_colors.dart';
import 'package:employee_management/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class SliverBar extends StatelessWidget {
  final String title;
  const SliverBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.lightGreyColor,
      title: Text(title,
          style: AppTextStyles.bodyTinyMedium(color: AppColors.primary)),
    );
  }
}

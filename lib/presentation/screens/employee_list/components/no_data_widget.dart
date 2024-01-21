import 'package:employee_management/core/styles/app_colors.dart';
import 'package:employee_management/core/styles/app_images.dart';
import 'package:employee_management/core/styles/app_strings.dart';
import 'package:employee_management/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lightGreyColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.emptyData,
              width: 250,
            ),
            Text(AppStrings.noEmployeeFound, style: AppTextStyles.bodyMedium())
          ],
        ),
      ),
    );
  }
}

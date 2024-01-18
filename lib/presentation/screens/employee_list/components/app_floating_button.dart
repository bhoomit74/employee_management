import 'package:employee_management/core/styles/app_colors.dart';
import 'package:employee_management/core/styles/app_images.dart';
import 'package:employee_management/presentation/screens/employee_detail/employee_detail_screen.dart';
import 'package:flutter/material.dart';

class AppFloatingButton extends StatelessWidget {
  const AppFloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const EmployeeDetailScreen()));
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            color: AppColors.primary, borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: Image.asset(AppImages.plusIcon, width: 18, height: 18)),
      ),
    );
  }
}

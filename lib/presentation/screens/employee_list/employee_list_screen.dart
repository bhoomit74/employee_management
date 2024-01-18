import 'package:employee_management/core/styles/app_colors.dart';
import 'package:employee_management/core/styles/app_images.dart';
import 'package:employee_management/core/styles/app_text_styles.dart';
import 'package:employee_management/presentation/screens/employee_list/components/add_employee_floating_button.dart';
import 'package:flutter/material.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Employee List",
              style: AppTextStyles.bodyMedium(color: AppColors.white)),
          backgroundColor: AppColors.primary,
        ),
        floatingActionButton: const AddEmployeeFloatingButton(),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.emptyData,
                    width: 250,
                  ),
                  Text("No employee records found",
                      style: AppTextStyles.bodyMedium())
                ],
              ),
            ),
          ),
        ));
  }
}

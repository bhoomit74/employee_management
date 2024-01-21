import 'package:employee_management/core/styles/app_colors.dart';
import 'package:employee_management/core/styles/app_images.dart';
import 'package:employee_management/core/styles/app_text_styles.dart';
import 'package:employee_management/core/utils/date_extension.dart';
import 'package:employee_management/domain/employee.dart';
import 'package:employee_management/presentation/screens/employee_detail/bloc/employee_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeTile extends StatelessWidget {
  final Employee employee;
  const EmployeeTile({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: AppColors.red,
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Image.asset(
                AppImages.delete,
                width: 24,
                height: 24,
              ),
            ),
          ),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          context.read<EmployeeCubit>().deleteEmployee(employee);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(employee.name, style: AppTextStyles.bodySmallMedium()),
              const SizedBox(height: 6),
              Text(employee.role,
                  style:
                      AppTextStyles.bodyTinyMedium(color: AppColors.hintColor)),
              const SizedBox(height: 6),
              Text(getWorkDurationText(employee),
                  style:
                      AppTextStyles.bodyExtraTiny(color: AppColors.hintColor)),
            ],
          ),
        ));
  }

  String getWorkDurationText(Employee employee) {
    if (employee.endDate == null) {
      return 'From ${employee.startDate.formatted}';
    } else {
      return '${employee.startDate.formatted} - ${employee.endDate.formatted}';
    }
  }
}

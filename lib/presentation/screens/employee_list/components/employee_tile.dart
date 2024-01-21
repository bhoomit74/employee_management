import 'package:employee_management/core/styles/app_colors.dart';
import 'package:employee_management/core/styles/app_text_styles.dart';
import 'package:employee_management/core/utils/date_extension.dart';
import 'package:employee_management/domain/employee.dart';
import 'package:employee_management/presentation/screens/employee_detail/bloc/employee_cubit.dart';
import 'package:employee_management/presentation/screens/employee_detail/employee_detail_screen.dart';
import 'package:employee_management/presentation/screens/employee_list/components/dismissible_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeTile extends StatelessWidget {
  final Employee employee;
  const EmployeeTile({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DismissibleTile(
      onDismiss: () => context.read<EmployeeCubit>().deleteEmployee(employee),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => navigateToEmployeeDetail(context),
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
        ),
      ),
    );
  }

  String getWorkDurationText(Employee employee) {
    if (employee.endDate == null) {
      return 'From ${employee.startDate.formatted}';
    } else {
      return '${employee.startDate.formatted} - ${employee.endDate.formatted}';
    }
  }

  navigateToEmployeeDetail(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmployeeDetailScreen(employee: employee),
        ));
  }
}

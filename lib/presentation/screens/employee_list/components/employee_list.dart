import 'package:employee_management/core/styles/app_colors.dart';
import 'package:employee_management/domain/model/employee.dart';
import 'package:employee_management/presentation/screens/employee_list/components/employee_tile.dart';
import 'package:flutter/material.dart';

class EmployeeList extends StatelessWidget {
  final List<Employee> employees;
  const EmployeeList({Key? key, required this.employees}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: employees.length,
      itemBuilder: (context, index) {
        return EmployeeTile(employee: employees[index]);
      },
      separatorBuilder: (context, index) {
        return const Divider(
          color: AppColors.borderColor,
          height: 0.3,
        );
      },
    );
  }
}

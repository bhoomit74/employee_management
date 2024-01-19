import 'package:employee_management/core/styles/app_strings.dart';
import 'package:employee_management/domain/employee.dart';
import 'package:employee_management/presentation/common_widgets/top_bar.dart';
import 'package:employee_management/presentation/screens/employee_detail/bloc/employee_cubit.dart';
import 'package:employee_management/presentation/screens/employee_detail/employee_detail_screen.dart';
import 'package:employee_management/presentation/screens/employee_list/components/app_floating_button.dart';
import 'package:employee_management/presentation/screens/employee_list/components/employee_tile.dart';
import 'package:employee_management/presentation/screens/employee_list/components/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeCubit, EmployeeState>(
      builder: (context, state) {
        List<Employee> employees = context.read<EmployeeCubit>().employees;
        return Scaffold(
            appBar: const TopBar(title: AppStrings.employeeList),
            floatingActionButton: const AppFloatingButton(),
            body: SafeArea(
              child: employees.isEmpty
                  ? const NoDataWidget()
                  : ListView.builder(
                      itemCount: employees.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () => navigateToEmployeeDetail(
                                context, employees[index]),
                            behavior: HitTestBehavior.opaque,
                            child: EmployeeTile(employee: employees[index]));
                      },
                    ),
            ));
      },
    );
  }

  ///We just have two screen that's why it's easy to handle navigation this way,
  ///Otherwise we have to manage route.
  navigateToEmployeeDetail(BuildContext context, Employee employee) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmployeeDetailScreen(employee: employee),
        ));
  }
}

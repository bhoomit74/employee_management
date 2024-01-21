import 'package:employee_management/core/styles/app_colors.dart';
import 'package:employee_management/core/styles/app_strings.dart';
import 'package:employee_management/core/styles/app_text_styles.dart';
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
        List<Employee> currentEmployees =
            context.read<EmployeeCubit>().currentEmployees;
        List<Employee> previousEmployees =
            context.read<EmployeeCubit>().previousEmployees;
        return Scaffold(
            appBar: const TopBar(title: AppStrings.employeeList),
            floatingActionButton: const AppFloatingButton(),
            body: SafeArea(
                child: employees.isEmpty
                    ? const NoDataWidget()
                    : CustomScrollView(
                        slivers: [
                          SliverAppBar(
                            backgroundColor: AppColors.borderColor,
                            title: Text("Current Employee",
                                style: AppTextStyles.bodySmall(
                                    color: AppColors.primary)),
                          ),
                          SliverList.separated(
                            itemCount: currentEmployees.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () => navigateToEmployeeDetail(
                                      context, currentEmployees[index]),
                                  behavior: HitTestBehavior.opaque,
                                  child: EmployeeTile(
                                      employee: currentEmployees[index]));
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(
                                color: AppColors.borderColor,
                                height: 0.5,
                              );
                            },
                          ),
                          SliverAppBar(
                            backgroundColor: AppColors.borderColor,
                            title: Text("Previous Employee",
                                style: AppTextStyles.bodySmall(
                                    color: AppColors.primary)),
                          ),
                          SliverList.separated(
                            itemCount: previousEmployees.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () => navigateToEmployeeDetail(
                                      context, previousEmployees[index]),
                                  behavior: HitTestBehavior.opaque,
                                  child: EmployeeTile(
                                      employee: previousEmployees[index]));
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(
                                color: AppColors.borderColor,
                                height: 0.5,
                              );
                            },
                          ),
                        ],
                      )));
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

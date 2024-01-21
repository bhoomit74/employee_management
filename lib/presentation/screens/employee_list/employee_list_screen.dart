import 'package:employee_management/core/styles/app_strings.dart';
import 'package:employee_management/presentation/common_widgets/top_bar.dart';
import 'package:employee_management/presentation/screens/employee_detail/bloc/employee_cubit.dart';
import 'package:employee_management/presentation/screens/employee_list/components/app_floating_button.dart';
import 'package:employee_management/presentation/screens/employee_list/components/employee_list.dart';
import 'package:employee_management/presentation/screens/employee_list/components/no_data_widget.dart';
import 'package:employee_management/presentation/screens/employee_list/components/sliver_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EmployeeCubit cubit = context.read<EmployeeCubit>();
    return BlocBuilder<EmployeeCubit, EmployeeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: const TopBar(title: AppStrings.employeeList),
          floatingActionButton: const AppFloatingButton(),
          body: SafeArea(
            child: cubit.employees.isEmpty
                ? const NoDataWidget()
                : CustomScrollView(
                    slivers: [
                      const SliverBar(title: AppStrings.currentEmployees),
                      EmployeeList(employees: cubit.currentEmployees),
                      const SliverBar(title: AppStrings.previousEmployees),
                      EmployeeList(employees: cubit.previousEmployees)
                    ],
                  ),
          ),
        );
      },
    );
  }
}

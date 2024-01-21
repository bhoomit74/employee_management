import 'package:employee_management/core/styles/app_colors.dart';
import 'package:employee_management/core/styles/app_strings.dart';
import 'package:employee_management/core/styles/app_text_styles.dart';
import 'package:employee_management/presentation/bloc/employee_cubit.dart';
import 'package:employee_management/presentation/common_widgets/top_bar.dart';
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
    return BlocConsumer<EmployeeCubit, EmployeeState>(
      buildWhen: (previous, current) =>
          current is EmployeesFetch || current is EmployeesUpdate,
      listener: (context, state) {
        if (state is EmployeesDelete) showDeleteSnackBar(context);
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.lightGreyColor,
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
                      EmployeeList(employees: cubit.previousEmployees),
                      SliverAppBar(
                          backgroundColor: AppColors.lightGreyColor,
                          title: Text(
                            AppStrings.swipeLeftToDelete,
                            style: AppTextStyles.bodyTiny(
                                color: AppColors.hintColor),
                          ))
                    ],
                  ),
          ),
        );
      },
    );
  }

  showDeleteSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text(AppStrings.employeeDeleted),
      action: SnackBarAction(
          label: AppStrings.undo,
          textColor: AppColors.primary,
          onPressed: () {
            context.read<EmployeeCubit>().undoDelete();
          }),
    ));
  }
}

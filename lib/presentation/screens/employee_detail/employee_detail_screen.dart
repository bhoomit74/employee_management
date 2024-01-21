import 'package:employee_management/core/styles/app_colors.dart';
import 'package:employee_management/core/styles/app_images.dart';
import 'package:employee_management/core/styles/app_strings.dart';
import 'package:employee_management/core/utils/date_extension.dart';
import 'package:employee_management/domain/model/employee.dart';
import 'package:employee_management/presentation/bloc/employee_cubit.dart';
import 'package:employee_management/presentation/common_widgets/app_text_field.dart';
import 'package:employee_management/presentation/common_widgets/bottom_action_bar.dart';
import 'package:employee_management/presentation/common_widgets/top_bar.dart';
import 'package:employee_management/presentation/screens/employee_detail/components/app_calendar.dart';
import 'package:employee_management/presentation/screens/employee_detail/components/select_role_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeDetailScreen extends StatefulWidget {
  final Employee? employee;
  const EmployeeDetailScreen({Key? key, this.employee}) : super(key: key);

  @override
  State<EmployeeDetailScreen> createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
  late EmployeeCubit cubit;
  late String title;
  List<Widget> actions = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  @override
  void initState() {
    cubit = context.read<EmployeeCubit>();
    bool editEmployee = widget.employee != null;

    //add actionbar title;
    title = editEmployee
        ? AppStrings.editEmployeeDetails
        : AppStrings.addEmployeeDetails;

    ///Add action in actionbar in case of edit employee.
    if (editEmployee) {
      actions.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: GestureDetector(
          onTap: () {
            cubit.deleteEmployee(widget.employee!);
            Navigator.pop(context);
          },
          behavior: HitTestBehavior.opaque,
          child: Image.asset(AppImages.delete, width: 24, height: 24),
        ),
      ));
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      cubit.selectEmployee(widget.employee);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeCubit, EmployeeState>(
      listener: (context, state) {
        if (state is RoleChange) {
          roleController.text = state.role;
          Navigator.pop(context);
        } else if (state is Error) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        } else if (state is EmployeesUpdate) {
          Navigator.pop(context);
        } else if (state is StartDateChange) {
          startDateController.text = state.startDate.stringify;
          Navigator.pop(context);
        } else if (state is EndDateChange) {
          endDateController.text = state.endDate.stringify;
          Navigator.pop(context);
        } else if (state is EmployeeSelected) {
          nameController.text = state.employee.name;
          roleController.text = state.employee.role;
          startDateController.text = state.employee.startDate.stringify;
          endDateController.text = state.employee.endDate.stringify;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: TopBar(title: title, actions: actions),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      AppTextField(
                          controller: nameController,
                          hint: AppStrings.employeeName,
                          onChange: cubit.onEmployeeNameChange,
                          prefixIconPath: AppImages.person),
                      const SizedBox(height: 23),
                      AppTextField(
                        controller: roleController,
                        hint: AppStrings.selectRole,
                        readOnly: true,
                        onTap: () {
                          showSelectRoleBottomSheet(context);
                        },
                        prefixIconPath: AppImages.work,
                        suffixIconPath: AppImages.dropDown,
                      ),
                      const SizedBox(height: 23),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                                controller: startDateController,
                                hint: "Today",
                                readOnly: true,
                                onTap: () {
                                  AppCalendar(
                                          selectedDate: cubit
                                              .selectedEmployee.startDate
                                              .toDateTime(),
                                          firstDate: DateTime(2023),
                                          onSelect: cubit.selectStartDate)
                                      .show(context);
                                },
                                prefixIconPath: AppImages.event),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Image.asset(
                              AppImages.arrowRight,
                              color: AppColors.primary,
                              width: 20,
                              height: 20,
                            ),
                          ),
                          Expanded(
                            child: AppTextField(
                                controller: endDateController,
                                hint: "No date",
                                readOnly: true,
                                onTap: () {
                                  AppCalendar(
                                    selectedDate: cubit
                                        .selectedEmployee.startDate
                                        .toDateTime(),
                                    firstDate: cubit.selectedEmployee.startDate
                                        .toDateTime(),
                                    onSelect: cubit.selectEndDate,
                                    isForEndDate: true,
                                  ).show(context);
                                },
                                prefixIconPath: AppImages.event),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                BottomActionBar(
                  onSave: () {
                    widget.employee == null
                        ? cubit.addEmployee()
                        : cubit.editEmployee();
                  },
                  onCancel: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  showSelectRoleBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (context) {
        return const SelectRolePage();
      },
    );
  }
}

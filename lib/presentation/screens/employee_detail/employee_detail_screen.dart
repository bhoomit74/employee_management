import 'package:employee_management/core/styles/app_colors.dart';
import 'package:employee_management/core/styles/app_images.dart';
import 'package:employee_management/core/styles/app_strings.dart';
import 'package:employee_management/domain/employee.dart';
import 'package:employee_management/presentation/common_widgets/action_buttons.dart';
import 'package:employee_management/presentation/common_widgets/app_text_field.dart';
import 'package:employee_management/presentation/common_widgets/top_bar.dart';
import 'package:employee_management/presentation/screens/employee_detail/bloc/employee_cubit.dart';
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
  String appTitle = AppStrings.addEmployeeDetails;
  TextEditingController nameController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  @override
  void initState() {
    cubit = context.read<EmployeeCubit>();

    ///If we got employee then it's for edit.
    if (widget.employee != null) {
      cubit.setEmployeeToEdit(widget.employee!);
      nameController.text = widget.employee?.name ?? "";
      roleController.text = widget.employee?.role ?? "";
      startDateController.text = widget.employee?.startDate ?? "";
      endDateController.text = widget.employee?.endDate ?? "";
      appTitle = AppStrings.editEmployeeDetails;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeCubit, EmployeeState>(
      listener: (context, state) {
        if (state is RoleChange) {
          ///Change role and Hide bottom-sheet.
          roleController.text = state.role;
          Navigator.pop(context);
        } else if (state is Error) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        } else if (state is EmployeesUpdate) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: TopBar(title: appTitle),
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
                                prefixIconPath: AppImages.event),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ActionButtons(
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

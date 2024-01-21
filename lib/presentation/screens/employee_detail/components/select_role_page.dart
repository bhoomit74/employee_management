import 'package:employee_management/core/styles/app_colors.dart';
import 'package:employee_management/core/styles/app_text_styles.dart';
import 'package:employee_management/presentation/bloc/employee_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectRolePage extends StatelessWidget {
  const SelectRolePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              context.read<EmployeeCubit>().selectRole(roles[index]);
            },
            behavior: HitTestBehavior.opaque,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child:
                    Text(roles[index], style: AppTextStyles.bodySmallMedium()),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 0.5,
            color: AppColors.borderColor,
          );
        },
        itemCount: roles.length);
  }

  List<String> get roles =>
      ["Product Designer", "Flutter Developer", "QA Tester", "Product Owner"];
}

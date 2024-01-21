import 'package:employee_management/core/styles/app_colors.dart';
import 'package:employee_management/core/styles/app_text_styles.dart';
import 'package:employee_management/presentation/bloc/employee_cubit.dart';
import 'package:employee_management/presentation/screens/employee_list/employee_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("Employees");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Employee management',
        theme: ThemeData(
          datePickerTheme: DatePickerThemeData(
              dayStyle: AppTextStyles.bodySmall(),
              todayBorder:
                  const BorderSide(color: AppColors.primary, width: 1)),
          colorScheme: ColorScheme.fromSwatch(
              backgroundColor: AppColors.white, accentColor: AppColors.primary),
          useMaterial3: true,
        ),
        home: const EmployeeListScreen(),
      ),
    );
  }
}

import 'package:employee_management/core/styles/app_colors.dart';
import 'package:employee_management/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  const TopBar({Key? key, required this.title, this.actions = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:
          Text(title, style: AppTextStyles.bodyMedium(color: AppColors.white)),
      actions: actions,
      backgroundColor: AppColors.primary,
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 56);
}

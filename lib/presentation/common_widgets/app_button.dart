import 'package:employee_management/core/styles/app_colors.dart';
import 'package:employee_management/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;
  final Function() onTap;
  final bool isSecondaryButton;
  const AppButton(
      {Key? key,
      required this.label,
      required this.onTap,
      this.isSecondaryButton = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onTap,
      style: ButtonStyle(
        shape: MaterialStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
        backgroundColor: MaterialStatePropertyAll<Color>(
            isSecondaryButton ? AppColors.primary100 : AppColors.primary),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Text(label,
            style: AppTextStyles.bodyTiny(
                color:
                    isSecondaryButton ? AppColors.primary : AppColors.white)),
      ),
    );
  }
}

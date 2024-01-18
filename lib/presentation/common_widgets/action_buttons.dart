import 'package:employee_management/core/styles/app_colors.dart';
import 'package:employee_management/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final Function() onSave;
  final Function() onCancel;
  const ActionButtons({Key? key, required this.onSave, required this.onCancel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 1, color: AppColors.borderColor),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FilledButton(
                onPressed: onCancel,
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4))),
                  backgroundColor: const MaterialStatePropertyAll<Color>(
                      AppColors.primary100),
                ),
                child: Text("Cancel",
                    style:
                        AppTextStyles.bodyTinyMedium(color: AppColors.primary)),
              ),
              const SizedBox(width: 16),
              FilledButton(
                onPressed: onSave,
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4))),
                  backgroundColor:
                      const MaterialStatePropertyAll<Color>(AppColors.primary),
                ),
                child: Text("Save",
                    style:
                        AppTextStyles.bodyTinyMedium(color: AppColors.white)),
              )
            ],
          ),
        ),
      ],
    );
  }
}

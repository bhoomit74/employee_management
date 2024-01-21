import 'package:employee_management/core/styles/app_colors.dart';
import 'package:employee_management/core/styles/app_text_styles.dart';
import 'package:employee_management/presentation/common_widgets/app_button.dart';
import 'package:flutter/material.dart';

class BottomActionBar extends StatelessWidget {
  final Function() onSave;
  final Function() onCancel;
  final String? prefixIcon;
  final String? prefixLabel;
  const BottomActionBar(
      {Key? key,
      required this.onSave,
      required this.onCancel,
      this.prefixIcon,
      this.prefixLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 1, color: AppColors.borderColor),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              prefixIcon != null
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(prefixIcon!, width: 24, height: 24),
                        const SizedBox(width: 8),
                        Text(prefixLabel ?? "", style: AppTextStyles.bodyTiny())
                      ],
                    )
                  : const SizedBox.shrink(),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButton(
                      label: "Cancel",
                      onTap: onCancel,
                      isSecondaryButton: true),
                  const SizedBox(width: 16),
                  AppButton(label: "Save", onTap: onSave)
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

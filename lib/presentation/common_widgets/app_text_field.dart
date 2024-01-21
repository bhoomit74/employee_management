import 'package:employee_management/core/styles/app_colors.dart';
import 'package:employee_management/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String? prefixIconPath;
  final String? suffixIconPath;
  final bool readOnly;
  final Function()? onTap;
  final Function(String value)? onChange;
  const AppTextField(
      {Key? key,
      required this.controller,
      required this.hint,
      this.prefixIconPath,
      this.suffixIconPath,
      this.readOnly = false,
      this.onTap,
      this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 40, maxHeight: 40),
      child: TextFormField(
        controller: controller,
        onChanged: onChange,
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            hintText: hint,
            hintStyle: AppTextStyles.hintTextStyle,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: AppColors.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: AppColors.focusedBorderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: AppColors.borderColor),
            ),
            prefixIcon: prefixIconPath != null
                ? Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      prefixIconPath!,
                      color: AppColors.primary,
                      width: 19,
                      height: 17,
                    ),
                  )
                : null,
            suffixIcon: suffixIconPath != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      suffixIconPath!,
                      color: AppColors.primary,
                      width: 20,
                      height: 20,
                    ),
                  )
                : null),
        onTap: () => onTap?.call(),
        readOnly: readOnly,
      ),
    );
  }
}

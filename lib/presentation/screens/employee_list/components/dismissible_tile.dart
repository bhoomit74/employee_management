import 'package:employee_management/core/styles/app_colors.dart';
import 'package:employee_management/core/styles/app_images.dart';
import 'package:flutter/material.dart';

class DismissibleTile extends StatelessWidget {
  final Widget child;
  final Function() onDismiss;
  const DismissibleTile(
      {Key? key, required this.child, required this.onDismiss})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: AppColors.red,
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Image.asset(
                AppImages.delete,
                width: 24,
                height: 24,
              ),
            ),
          ),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) => onDismiss(),
        child: child);
  }
}

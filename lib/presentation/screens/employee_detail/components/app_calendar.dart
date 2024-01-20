import 'package:employee_management/core/styles/app_colors.dart';
import 'package:employee_management/core/styles/app_images.dart';
import 'package:employee_management/core/utils/app_date_format.dart';
import 'package:employee_management/presentation/common_widgets/app_button.dart';
import 'package:employee_management/presentation/common_widgets/bottom_action_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppCalendar extends StatefulWidget {
  final DateTime selectedDate;
  final DateTime firstDate;
  final Function(DateTime dateTime) onSelect;
  const AppCalendar(
      {Key? key,
      required this.selectedDate,
      required this.firstDate,
      required this.onSelect})
      : super(key: key);

  @override
  State<AppCalendar> createState() => _AppCalendarState();
}

class _AppCalendarState extends State<AppCalendar> {
  DateTime date = DateTime.now();

  @override
  void initState() {
    date = widget.selectedDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 40,
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16),
                    children: [
                      AppButton(
                          label: "Today",
                          onTap: () {
                            setState(() {
                              date = DateTime.now();
                            });
                          },
                          isSecondaryButton:
                              !DateUtil.isSameDay(DateTime.now(), date)),
                      AppButton(
                        label: "Next Monday",
                        onTap: () {
                          setState(() {
                            date = DateUtil.getNextDate(DateTime.monday);
                          });
                        },
                        isSecondaryButton: !DateUtil.isSameDay(
                            DateUtil.getNextDate(DateTime.monday), date),
                      ),
                      AppButton(
                          label: "Next Tuesday",
                          onTap: () {
                            setState(() {
                              date = DateUtil.getNextDate(DateTime.tuesday);
                            });
                          },
                          isSecondaryButton: !DateUtil.isSameDay(
                              DateUtil.getNextDate(DateTime.tuesday), date)),
                      AppButton(
                          label: "After 1 Week",
                          onTap: () {
                            setState(() {
                              date = DateUtil.getDateAfterWeek();
                            });
                          },
                          isSecondaryButton: !DateUtil.isSameDay(
                              DateUtil.getDateAfterWeek(), date)),
                    ],
                  ),
                ),
                CalendarDatePicker(
                    initialDate: date,
                    firstDate: widget.firstDate,
                    lastDate: DateTime(2026),
                    onDateChanged: (value) => setState(() {
                          date = value;
                        })),
                BottomActionBar(
                    prefixIcon: AppImages.event,
                    prefixLabel: DateFormat("dd MMM yyyy").format(date),
                    onSave: () => widget.onSelect(date),
                    onCancel: () => Navigator.pop(context))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

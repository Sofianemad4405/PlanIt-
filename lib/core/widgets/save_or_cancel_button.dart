import 'package:flutter/material.dart';
import 'package:planitt/core/theme/app_colors.dart';
import 'package:planitt/core/theme/app_numbers.dart';

class SaveOrCancelButton extends StatelessWidget {
  const SaveOrCancelButton({super.key, required this.isCancel});
  final bool isCancel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.01,
      width: isCancel ? 80.74 : 64.64,
      decoration: BoxDecoration(
        border: Border.all(
          color: isCancel
              ? DarkMoodAppColors.kUnSelectedItemColor
              : DarkMoodAppColors.kSelectedItemColor,
        ),
        color: isCancel
            ? Colors.transparent
            : DarkMoodAppColors.kSelectedItemColor,
        borderRadius: BorderRadius.circular(AppNumbers.kEight),
      ),
      child: Center(
        child: Text(
          isCancel ? "Cancel" : "Save",
          style: TextStyle(color: DarkMoodAppColors.kWhiteColor),
        ),
      ),
    );
  }
}

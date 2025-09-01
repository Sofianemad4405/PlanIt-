import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:planitt/core/theme/app_colors.dart';
import 'package:planitt/core/theme/app_numbers.dart';
import 'package:planitt/core/theme/text_themes.dart';

class AddNewProject extends StatelessWidget {
  const AddNewProject({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppNumbers.kOneTwoThree,
      height: AppNumbers.kThirtyNine,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppNumbers.kEight),
        color: AppColors.kAddTodoColor,
      ),
      child: Center(
        child: Text(
          "+  New Project".tr(),
          style: TextThemes.whiteMedium.copyWith(fontSize: 13.6),
        ),
      ),
    );
  }
}

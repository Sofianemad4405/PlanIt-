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
        color: DarkMoodAppColors.kProjectIconColor1,
      ),
      child: Center(
        child: Text(
          "+  New Project",
          style: TextThemes.whiteMedium.copyWith(fontSize: 13.6),
        ),
      ),
    );
  }
}

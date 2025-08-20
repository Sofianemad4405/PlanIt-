import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:planitt/core/theme/app_colors.dart';

class CustomDialogRow extends StatelessWidget {
  const CustomDialogRow({
    super.key,
    required this.mainIcon,
    required this.text,
    required this.smallIcon,
    required this.onTap,
  });
  final IconData mainIcon;
  final String text;
  final IconData smallIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(mainIcon, color: DarkMoodAppColors.kUnSelectedItemColor),
          Gap(5),
          Expanded(
            child: Container(
              height: 35.97,
              decoration: BoxDecoration(
                border: Border.all(
                  color: DarkMoodAppColors.kTextFieldBorderSideColor,
                ),
                color: Color(0xff1A1A1F),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      text,
                      style: TextStyle(color: DarkMoodAppColors.kWhiteColor),
                    ),
                    Spacer(),
                    Icon(smallIcon, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

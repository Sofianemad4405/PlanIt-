import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:planitt/core/theme/app_colors.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({
    super.key,
    required this.mainIcon,
    required this.smallIcon,
    required this.text,
    required this.onTap,
  });
  final Widget mainIcon;
  final Widget smallIcon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          mainIcon,
          Gap(5),
          Expanded(
            child: Container(
              height: 35.97,
              decoration: BoxDecoration(
                border: Border.all(
                  color: DarkMoodAppColors.kTextFieldBorderSideColor,
                ),
                color: DarkMoodAppColors.kFillColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [Text(text), Spacer(), smallIcon]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

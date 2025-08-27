import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:planitt/core/theme/app_colors.dart';

class EditToDoCustomColumn extends StatelessWidget {
  const EditToDoCustomColumn({
    super.key,
    required this.title,
    required this.data,
    required this.icon,
    required this.isContainer,
    required this.isEditing,
  });

  final String title;
  final IconData icon;
  final Widget data;
  final bool isContainer;
  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: DarkMoodAppColors.kUnSelectedItemColor, size: 20),
            const Gap(10),
            Text(
              title,
              style: const TextStyle(
                color: DarkMoodAppColors.kUnSelectedItemColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const Gap(10),
        isContainer
            ? SizedBox(
                height: isEditing ? 40 : 30,
                width: isEditing ? double.infinity : 70,
                child: data,
              )
            : data,
      ],
    );
  }
}

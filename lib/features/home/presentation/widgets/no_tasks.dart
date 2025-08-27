import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:planitt/core/theme/app_colors.dart';

class NoTasks extends StatelessWidget {
  const NoTasks({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset("assets/svgs/no_tasks.svg", height: 40, width: 40),
        const Text(
          "No tasks found",
          style: TextStyle(
            color: DarkMoodAppColors.kWhiteColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(5),
        Text(
          text,
          style: const TextStyle(
            color: DarkMoodAppColors.kUnSelectedItemColor,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
        const Gap(5),
      ],
    );
  }
}

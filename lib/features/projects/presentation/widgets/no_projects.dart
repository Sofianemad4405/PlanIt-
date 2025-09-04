import 'package:easy_localization/easy_localization.dart' as text;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class NoProjects extends StatelessWidget {
  const NoProjects({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animations/no_tasks.json',
            repeat: true,
            width: 300,
            height: 300,
          ),
          Text(
            "You don’t have any projects yet".tr(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(5),
          Text(
            text.tr(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          const Gap(5),
        ],
      ),
    );
  }
}

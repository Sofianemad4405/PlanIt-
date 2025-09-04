import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:planitt/core/widgets/task_search_field.dart';

class TimerSettings extends StatelessWidget {
  const TimerSettings({
    super.key,
    required this.focusController,
    required this.breakController,
    this.onFocusChanged,
    this.onbreakChanged,
  });
  final TextEditingController focusController;
  final TextEditingController breakController;
  final Function(String)? onFocusChanged;
  final Function(String)? onbreakChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Timer Settings".tr(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(20),
            Text(
              "Focus Duration (minutes)".tr(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Gap(10),
            CustomTextField(
              hint: "",
              prefixIcon: false,
              controller: focusController,
              keyboardType: const TextInputType.numberWithOptions(),
              onChanged: onFocusChanged,

              // (value) {
              //   setState(() {
              //     _focusDurationController.text = value;
              //     PreferencesService.saveInt("focusDuration", int.parse(value));
              //   });
            ),
            const Gap(20),
            Text(
              "Break Duration (minutes)".tr(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Gap(10),
            CustomTextField(
              hint: "",
              prefixIcon: false,
              controller: breakController,
              keyboardType: const TextInputType.numberWithOptions(),
              onChanged: onbreakChanged,
              // if (value.isEmpty) {
              //   _breakDurationController.text = "25";
              //   _breakDurationController
              //       .selection = TextSelection.fromPosition(
              //     TextPosition(offset: _breakDurationController.text.length),
              //   );
              // } else {
              //   final parsed = int.tryParse(value) ?? 25;
              //   if (parsed < 1) {
              //     _breakDurationController.text = "1";
              //   } else if (parsed > 900) {
              //     _breakDurationController.text = "900";
              //   }
              //   _countDownController.pause();
              //   _countDownController.start();
              // }
              // setState(() {
              //   isTimerRunning = false;
              //   isTimerRunningAndNowPaused = true;
              // });
              // },
            ),
          ],
        ),
      ),
    );
  }
}

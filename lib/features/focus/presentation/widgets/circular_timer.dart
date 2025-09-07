import 'dart:developer';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:planitt/core/services/prefs.dart';
import 'package:planitt/features/focus/domain/entities/focus_mode_enum.dart';
import 'package:planitt/features/focus/presentation/widgets/controller_button.dart';

class CircularTimer extends StatelessWidget {
  const CircularTimer({
    super.key,
    required this.focusMode,
    required this.duration,
    required this.countDownController,
    this.onComplete,
    required this.isTimerRunning,
    required this.isTimerRunningAndNowPaused,
    required this.onPause,
    required this.onReset,
    required this.onShiftMode,
  });
  final FocusMode focusMode;
  final int duration;
  final CountDownController countDownController;
  final Function()? onComplete;
  final bool isTimerRunning;
  final bool isTimerRunningAndNowPaused;
  final Function() onPause;
  final Function() onReset;
  final Function() onShiftMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 423.94,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                focusMode == FocusMode.breakTime
                    ? "Break Time".tr()
                    : "Focus Time".tr(),
                style: TextStyle(
                  color: focusMode == FocusMode.breakTime
                      ? const Color(0xFF10B981)
                      : const Color(0xFF4F46E5),
                  fontSize: 20.4,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                focusMode == FocusMode.breakTime
                    ? "Take a short break".tr()
                    : "Focus on one task".tr(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Gap(20),
              CircularCountDownTimer(
                key: ValueKey(duration),
                duration: duration,
                initialDuration: 0,
                controller: countDownController,
                width: 200,
                height: 192,
                ringColor: Colors.grey[400]!,
                fillColor: focusMode == FocusMode.breakTime
                    ? const Color(0xFF10B981)
                    : const Color(0xFF4F46E5),
                strokeWidth: 5.0,
                strokeCap: StrokeCap.round,
                textStyle: TextStyle(
                  fontSize: 30.0,
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
                isReverse: true,
                isTimerTextShown: true,
                autoStart: false,
                onComplete: onComplete,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ControllerButton(
                    icon: isTimerRunning
                        ? SvgPicture.asset("assets/svgs/pause.svg")
                        : SvgPicture.asset("assets/svgs/continue.svg"),
                    onPressed: onPause,
                    isPauseAndRunning: true,
                  ),
                  const Gap(10),
                  ControllerButton(
                    icon: SvgPicture.asset(
                      "assets/svgs/restart.svg",
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.onSurface,
                        BlendMode.srcIn,
                      ),
                    ),
                    onPressed: onReset,
                    isPauseAndRunning: false,
                  ),
                  const Gap(10),
                  ControllerButton(
                    icon: SvgPicture.asset(
                      "assets/svgs/shift.svg",
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.onSurface,
                        BlendMode.srcIn,
                      ),
                    ),
                    onPressed: onShiftMode,
                    isPauseAndRunning: false,
                  ),
                ],
              ),
              const Gap(20),
              Text(
                "${SessionService.sessions} ${"Sessions Completed".tr()}",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

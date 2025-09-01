import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:planitt/core/entities/to_do_entity.dart';
import 'package:planitt/core/services/prefs.dart';
import 'package:planitt/core/theme/app_colors.dart';
import 'package:planitt/core/widgets/task_search_field.dart';
import 'package:planitt/features/focus/presentation/widgets/controller_button.dart';
import 'package:planitt/features/home/presentation/cubit/todos_cubit.dart';
import 'package:planitt/features/home/presentation/widgets/todo_read_dialog.dart';

enum FocusMode { focus, breakTime }

class FocusPageViewBody extends StatefulWidget {
  const FocusPageViewBody({super.key});

  @override
  State<FocusPageViewBody> createState() => _FocusPageViewBodyState();
}

class _FocusPageViewBodyState extends State<FocusPageViewBody>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  final CountDownController _countDownController = CountDownController();

  FocusMode currentMode = FocusMode.focus;

  void switchMode(FocusMode mode, {bool autoStart = false}) {
    setState(() {
      currentMode = mode;
      _countDownController.restart(duration: _duration);
      if (autoStart) {
        _countDownController.start();
        isTimerRunning = true;
      } else {
        isTimerRunning = false;
      }
      isTimerRunningAndNowPaused = false;
    });
  }

  @override
  void initState() {
    super.initState();
    // getSessionsCompleted();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _focusDurationController.addListener(() {
      if (_focusDurationController.text.isEmpty) {
        // لو فضي خليه يرجع 25
        _focusDurationController.text = "25";
        _focusDurationController.selection = TextSelection.fromPosition(
          TextPosition(offset: _focusDurationController.text.length),
        );
      }
    });
    _breakDurationController.addListener(() {
      if (_breakDurationController.text.isEmpty) {
        // لو فضي خليه يرجع 25
        _breakDurationController.text = "5";
        _breakDurationController.selection = TextSelection.fromPosition(
          TextPosition(offset: _breakDurationController.text.length),
        );
      }
    });

    _offsetAnimation =
        Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.fastEaseInToSlowEaseOut,
          ),
        );

    _controller.forward();
    context.read<TodosCubit>().init();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startTimer() {
    _countDownController.start();
    setState(() {
      isTimerRunning = true;
      isTimerRunningAndNowPaused = false;
    });
  }

  void _pauseTimer() {
    _countDownController.pause();
    setState(() {
      isTimerRunning = false;
      isTimerRunningAndNowPaused = true;
    });
  }

  void _resumeTimer() {
    _countDownController.resume();
    setState(() {
      isTimerRunning = true;
      isTimerRunningAndNowPaused = false;
    });
  }

  bool focusingOnCustomTask = false;
  ToDoEntity? currentTodo;
  TextEditingController _focusDurationController = TextEditingController(
    text: "25",
  );
  TextEditingController _breakDurationController = TextEditingController(
    text: "5",
  );

  int get _duration {
    final text = currentMode == FocusMode.focus
        ? _focusDurationController.text
        : _breakDurationController.text;

    final value = int.tryParse(text) ?? 0;

    if (value < 1 || value > 900) {
      return 25 * 60; // default
    }
    return value * 60;
  }

  bool isSettingsShown = false;

  bool isTimerRunning = false;
  bool isTimerRunningAndNowPaused = false;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              Row(
                children: [
                  Text(
                    "Focus Mode".tr(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isSettingsShown = !isSettingsShown;
                      });
                    },
                    child: SvgPicture.asset(
                      "assets/svgs/Settings.svg",
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.onSurface,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(20),
              Visibility(
                visible: isSettingsShown,
                child: Container(
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
                          controller: _focusDurationController,
                          keyboardType: const TextInputType.numberWithOptions(),
                          onChanged: (value) {
                            setState(() {
                              _focusDurationController.text = value;
                            });
                          },
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
                          controller: _breakDurationController,
                          keyboardType: const TextInputType.numberWithOptions(),
                          onChanged: (value) {
                            if (value.isEmpty) {
                              _breakDurationController.text = "25";
                              _breakDurationController
                                  .selection = TextSelection.fromPosition(
                                TextPosition(
                                  offset: _breakDurationController.text.length,
                                ),
                              );
                            } else {
                              final parsed = int.tryParse(value) ?? 25;
                              if (parsed < 1) {
                                _breakDurationController.text = "1";
                              } else if (parsed > 900) {
                                _breakDurationController.text = "900";
                              }
                              _countDownController.pause();
                              _countDownController.start();
                            }
                            setState(() {
                              isTimerRunning = false;
                              isTimerRunningAndNowPaused = true;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Gap(20),
              Container(
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
                          currentMode == FocusMode.breakTime
                              ? "Break Time".tr()
                              : "Focus Time".tr(),
                          style: TextStyle(
                            color: currentMode == FocusMode.breakTime
                                ? const Color(0xFF10B981)
                                : const Color(0xFF4F46E5),
                            fontSize: 20.4,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          currentMode == FocusMode.breakTime
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
                          key: ValueKey(_duration),
                          duration: _duration,
                          initialDuration: 0,
                          controller: _countDownController,
                          width: 200,
                          height: 192,
                          ringColor: Colors.grey[800]!,
                          fillColor: currentMode == FocusMode.breakTime
                              ? const Color(0xFF10B981)
                              : const Color(0xFF4F46E5),
                          strokeWidth: 12.0,
                          strokeCap: StrokeCap.round,
                          textStyle: TextStyle(
                            fontSize: 40.0,
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                          isReverse: true,
                          isTimerTextShown: true,
                          autoStart: false,
                          onComplete: () async {
                            log("completed");
                            if (currentMode == FocusMode.focus) {
                              int completed =
                                  await PreferencesService.getInt(
                                    "Sessions completed",
                                  ) ??
                                  0;
                              completed += 1;
                              PreferencesService.saveInt(
                                "Sessions completed",
                                completed,
                              );
                              setState(() {
                                SessionService.sessions = completed;
                              });
                            }
                            switchMode(
                              currentMode == FocusMode.breakTime
                                  ? FocusMode.focus
                                  : FocusMode.breakTime,
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ControllerButton(
                              icon: isTimerRunning
                                  ? SvgPicture.asset("assets/svgs/pause.svg")
                                  : SvgPicture.asset(
                                      "assets/svgs/continue.svg",
                                    ),
                              onPressed: () {
                                if (!isTimerRunning &&
                                    !isTimerRunningAndNowPaused) {
                                  _startTimer();
                                  setState(() {
                                    isTimerRunning = true;
                                    isTimerRunningAndNowPaused = false;
                                  });
                                } else if (isTimerRunning) {
                                  _pauseTimer();
                                  setState(() {
                                    isTimerRunning = false;
                                    isTimerRunningAndNowPaused = true;
                                  });
                                } else {
                                  _resumeTimer();
                                  setState(() {
                                    isTimerRunning = true;
                                    isTimerRunningAndNowPaused = false;
                                  });
                                }
                              },
                              isPauseAndRunning: true,
                            ),
                            const Gap(10),
                            ControllerButton(
                              icon: SvgPicture.asset("assets/svgs/restart.svg"),
                              onPressed: () {
                                _countDownController.restart();
                                _countDownController.pause();
                                setState(() {
                                  isTimerRunning = false;
                                });
                              },
                              isPauseAndRunning: false,
                            ),
                            const Gap(10),
                            ControllerButton(
                              icon: SvgPicture.asset("assets/svgs/shift.svg"),
                              onPressed: () {
                                setState(() {
                                  switchMode(
                                    currentMode == FocusMode.breakTime
                                        ? FocusMode.focus
                                        : FocusMode.breakTime,
                                  );
                                });
                                _countDownController.restart();
                                _countDownController.pause();
                              },
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
              ),
              const Gap(20),
              Visibility(
                visible: focusingOnCustomTask,
                child: Container(
                  height: 159.95,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Current Focus Task".tr(),
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  focusingOnCustomTask = false;
                                });
                                focusingOnCustomTask = false;
                                currentTodo = null;
                              },
                              child: Text(
                                "Change".tr(),
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(10),
                        Container(
                          height: 91.99,
                          width: 294.03,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentTodo?.title ?? "",
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Gap(10),
                                Text(
                                  currentTodo?.description ??
                                      "No description".tr(),
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Gap(20),
              Text(
                "High Priority Tasks".tr(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const Gap(20),
              BlocBuilder<TodosCubit, TodosState>(
                builder: (context, state) {
                  final highPriorityTasks = state is TodosLoaded
                      ? state.todos
                            .where((todo) => todo.priority == "High")
                            .toList()
                      : const [];
                  log(highPriorityTasks.length.toString());
                  if (highPriorityTasks.isNotEmpty) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: highPriorityTasks.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                              ),
                              child: FocusTodoTile(
                                onDeactivatingFocus: () {
                                  setState(() {
                                    focusingOnCustomTask = false;
                                  });
                                  currentTodo = null;
                                  _countDownController.restart();
                                  _countDownController.pause();
                                },
                                todo: highPriorityTasks[index],
                                onActivatingFocus: () {
                                  setState(() {
                                    focusingOnCustomTask = true;
                                  });
                                  currentTodo = highPriorityTasks[index];
                                  switchMode(FocusMode.focus);
                                  _startTimer();
                                },
                                isFocusing: focusingOnCustomTask,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {}
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FocusTodoTile extends StatelessWidget {
  const FocusTodoTile({
    super.key,
    required this.todo,
    required this.onActivatingFocus,
    required this.onDeactivatingFocus,
    required this.isFocusing,
  });
  final ToDoEntity todo;
  final VoidCallback onActivatingFocus;
  final VoidCallback onDeactivatingFocus;
  final bool isFocusing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 80,
      title: Text(todo.title),
      subtitle: Text(
        "${"Due".tr()} : ${DateFormat("yyyy/MM/dd", context.locale.toString()).format(todo.dueDate ?? DateTime.now())}",
        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      ),
      trailing: GestureDetector(
        onTap: () {
          onActivatingFocus();
        },
        child: isFocusing
            ? ControllerButton(
                icon: Icon(
                  Icons.check,
                  color: Theme.of(context).colorScheme.surface,
                ),
                onPressed: () {
                  onDeactivatingFocus();
                },
                isPauseAndRunning: true,
              )
            : SvgPicture.asset(
                "assets/svgs/continue.svg",
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return TodoReadDialog(toDoKey: todo.key);
          },
        );
      },
    );
  }
}

class SessionService {
  static int sessions = 0;

  static void increment() {
    sessions++;
  }

  static void reset() {
    sessions = 0;
  }
}

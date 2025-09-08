import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:planitt/core/entities/to_do_entity.dart';
import 'package:planitt/core/services/prefs.dart';
import 'package:planitt/core/theme/app_colors.dart';
import 'package:planitt/core/utils/constants.dart' as Constants;
import 'package:planitt/features/focus/domain/entities/focus_mode_enum.dart';
import 'package:planitt/features/focus/presentation/widgets/circular_timer.dart';
import 'package:planitt/features/focus/presentation/widgets/focus_todo_tile.dart';
import 'package:planitt/features/focus/presentation/widgets/timer_settings.dart';
import 'package:planitt/features/home/presentation/cubit/todos_cubit.dart';

class FocusPageViewBody extends StatefulWidget {
  const FocusPageViewBody({super.key});

  @override
  State<FocusPageViewBody> createState() => _FocusPageViewBodyState();
}

class _FocusPageViewBodyState extends State<FocusPageViewBody>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final _formKey = GlobalKey<FormState>();
  bool settingsShown = false;
  TextEditingController focusController = TextEditingController();
  TextEditingController breakController = TextEditingController();
  FocusMode focusMode = FocusMode.focus;
  int duration = 25;
  int breakDuration = 5;
  int focusDuration = 25;
  bool isTimerRunning = false;
  bool isTimerRunningAndNowPaused = false;
  CountDownController countDownController = CountDownController();
  bool isFocusing = false;
  ToDoEntity? currentTodo;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    getTimersValues();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _offsetAnimation =
        Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.fastEaseInToSlowEaseOut,
          ),
        );

    _controller.forward();
  }

  Future<void> getTimersValues() async {
    focusDuration = await PreferencesService.getInt(Constants.focusDurationKey);
    breakDuration = await PreferencesService.getInt(Constants.breakDurationKey);
    setState(() {
      duration = focusDuration;
    });
  }

  void onComplete() {
    setState(() {
      isTimerRunning = false;
      isTimerRunningAndNowPaused = false;
    });
  }

  void onPauseOrResume() {
    if (isTimerRunning) {
      countDownController.pause();
    } else {
      countDownController.start();
    }
    setState(() {
      isTimerRunning = !isTimerRunning;
      isTimerRunningAndNowPaused = !isTimerRunningAndNowPaused;
    });
  }

  void onReset() {
    countDownController.reset();
    setState(() {
      isTimerRunning = false;
      isTimerRunningAndNowPaused = false;
    });
  }

  void onShiftMode() {
    if (isTimerRunning) {
      isTimerRunning = false;
      isTimerRunningAndNowPaused = true;
    }
    setState(() {
      focusMode = focusMode == FocusMode.focus
          ? FocusMode.breakTime
          : FocusMode.focus;
      duration = focusMode == FocusMode.focus ? focusDuration : breakDuration;
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SlideTransition(
      position: _offsetAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Gap(20),
                Row(
                  children: [
                    Text(
                      "Focus Mode".tr(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          settingsShown = !settingsShown;
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
                  visible: settingsShown,
                  child: TimerSettings(
                    focusController: focusController,
                    breakController: breakController,
                    onFocusChanged: (value) {
                      setState(() {
                        focusDuration = int.parse(value) * 60;
                        duration = focusDuration;
                      });
                      PreferencesService.saveInt(
                        Constants.focusDurationKey,
                        focusDuration,
                      );
                    },
                    onbreakChanged: (value) {
                      setState(() {
                        breakDuration = int.parse(value) * 60;
                      });
                      PreferencesService.saveInt(
                        Constants.breakDurationKey,
                        breakDuration,
                      );
                    },
                  ),
                ),
                const Gap(20),

                /// circular timer
                CircularTimer(
                  focusMode: focusMode,
                  duration: focusMode == FocusMode.breakTime
                      ? breakDuration
                      : focusDuration,
                  countDownController: countDownController,
                  isTimerRunning: isTimerRunning,
                  isTimerRunningAndNowPaused: isTimerRunningAndNowPaused,
                  onPause: onPauseOrResume,
                  onReset: onReset,
                  onShiftMode: onShiftMode,
                  onComplete: onComplete,
                ),
                const Gap(20),
                Visibility(
                  visible: isFocusing,
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
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isFocusing = false;
                                  });
                                  currentTodo = null;
                                },
                                child: Text(
                                  "Change".tr(),
                                  style: const TextStyle(
                                    color: AppColors.kMediumPriorityColor,
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
                              color: Colors.grey[1000],
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
                Row(
                  children: [
                    Text(
                      "High Priority Tasks".tr(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                BlocBuilder<TodosCubit, TodosState>(
                  builder: (context, state) {
                    if (state is TodosLoaded) {
                      final todos = state.todos
                          .where(
                            (todo) =>
                                todo.priority == "High" ||
                                todo.priority == "Urgent",
                          )
                          .toList();
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: todos.length,
                        itemBuilder: (context, index) {
                          final todo = todos[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Theme.of(context).colorScheme.surface,
                            ),
                            child: FocusTodoTile(
                              todo: todo,
                              onActivatingFocus: () {
                                currentTodo = todo;
                                setState(() {
                                  isFocusing = true;
                                });
                                focusMode = FocusMode.focus;
                                isTimerRunning = true;
                                countDownController.start();
                              },
                              onDeactivatingFocus: () {
                                currentTodo = null;
                                setState(() {
                                  isFocusing = false;
                                });
                                countDownController.pause();
                                isTimerRunning = false;
                              },
                              isFocusing: isFocusing,
                            ),
                          );
                        },
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

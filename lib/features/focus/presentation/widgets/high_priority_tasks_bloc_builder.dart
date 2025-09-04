import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planitt/features/focus/presentation/widgets/focus_todo_tile.dart';
import 'package:planitt/features/home/presentation/cubit/todos_cubit.dart';

class HighPriorityTasksBlocBuilder extends StatelessWidget {
  const HighPriorityTasksBlocBuilder({
    super.key,
    required this.onActivatingFocus,
    required this.onDeactivatingFocus,
    required this.focusingOnCustomTask,
  });
  final Function() onActivatingFocus;
  final Function() onDeactivatingFocus;
  final bool focusingOnCustomTask;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosCubit, TodosState>(
      builder: (context, state) {
        final highPriorityTasks = state is TodosLoaded
            ? state.todos
                  .where(
                    (todo) =>
                        todo.priority == "High" || todo.priority == "Urgent",
                  )
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
                      onDeactivatingFocus: onDeactivatingFocus,
                      // () {
                      // setState(() {
                      //   focusingOnCustomTask = false;
                      // });
                      // currentTodo = null;
                      // _countDownController.restart();
                      // _countDownController.pause();
                      // }
                      todo: highPriorityTasks[index],
                      onActivatingFocus: onDeactivatingFocus,

                      // () {
                      //   setState(() {
                      //     focusingOnCustomTask = true;
                      //   });
                      //   currentTodo = highPriorityTasks[index];
                      //   switchMode(FocusMode.focus);
                      //   _startTimer();
                      // }
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
    );
  }
}

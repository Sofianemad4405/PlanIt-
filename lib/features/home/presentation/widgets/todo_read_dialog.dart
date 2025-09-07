import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart' as completed;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:planitt/core/entities/to_do_entity.dart';
import 'package:planitt/core/theme/app_colors.dart';
import 'package:planitt/core/utils/extention.dart';
import 'package:planitt/features/home/presentation/cubit/todos_cubit.dart';
import 'package:planitt/features/home/presentation/widgets/eidt_data_custom_column.dart';
import 'package:planitt/features/home/presentation/widgets/todo_editing_dialog.dart';

class TodoReadDialog extends StatefulWidget {
  const TodoReadDialog({super.key, required this.toDoKey});
  final String toDoKey;

  @override
  State<TodoReadDialog> createState() => _TodoReadDialogState();
}

class _TodoReadDialogState extends State<TodoReadDialog> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosCubit, TodosState>(
      builder: (context, state) {
        if (state is TodosLoaded) {
          final todo = state.todos.firstWhere(
            (todo) => todo.key == widget.toDoKey,
          );
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            child: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final maxW = constraints.maxWidth.clamp(280.0, 560.0);
                  final maxH = constraints.maxHeight.clamp(
                    200.0,
                    MediaQuery.of(context).size.height * 0.8,
                  );
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: maxW,
                      maxHeight: maxH,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .4,
                                  child: Text(
                                    todo.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      decoration: todo.isFinished
                                          ? TextDecoration.lineThrough
                                          : null,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  visualDensity: VisualDensity.compact,
                                  splashRadius: 18,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) =>
                                          TodoEditingDialog(toDo: todo),
                                    );
                                  },
                                  icon: SvgPicture.asset(
                                    "assets/svgs/pen.svg",
                                    height: 24,
                                    width: 24,
                                    colorFilter: ColorFilter.mode(
                                      Theme.of(context).colorScheme.onSurface,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  tooltip: 'Edit',
                                ),
                                IconButton(
                                  visualDensity: VisualDensity.compact,
                                  splashRadius: 18,
                                  onPressed: () async {
                                    await context.read<TodosCubit>().deleteTodo(
                                      todo,
                                    );
                                  },
                                  icon: SvgPicture.asset(
                                    "assets/svgs/trash.svg",
                                    height: 24,
                                    width: 24,
                                  ),
                                  tooltip: 'Delete',
                                ),
                                IconButton(
                                  visualDensity: VisualDensity.compact,
                                  splashRadius: 18,
                                  onPressed: () => context.pop(),
                                  icon: Icon(
                                    Iconsax.close_square,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                    size: 24,
                                  ),
                                  tooltip: 'Close',
                                ),
                              ],
                            ),
                            const Gap(10),
                            Text(
                              "Description".tr(),
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Gap(10),
                            Text(
                              todo.description ?? "No description".tr(),
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            const Gap(20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .4,
                                  child: EditToDoCustomColumn(
                                    isEditing: false,
                                    isContainer: false,
                                    title: "Due Date".tr(),
                                    data: Text(
                                      todo.dueDate != null
                                          ? DateFormat(
                                              'EEEE, MMMM d,\ny',
                                              context.locale.toString(),
                                            ).format(todo.dueDate!)
                                          : "No due date",
                                      style: TextStyle(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    icon: Iconsax.calendar,
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .4,
                                  child: EditToDoCustomColumn(
                                    isEditing: false,
                                    isContainer: true,
                                    title: "Priority".tr(),
                                    data: Container(
                                      decoration: BoxDecoration(
                                        color: todo.priority == "High"
                                            ? const Color(0xFF943211)
                                            : todo.priority == "Medium"
                                            ? const Color(0xFF1D3DA8)
                                            : todo.priority == "Low"
                                            ? const Color(0xFF353E4E)
                                            : todo.priority == "Urgent"
                                            ? const Color(0xFF931A1A)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Center(
                                          child: Text(
                                            todo.priority.tr(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    icon: Iconsax.flag,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .4,
                                  child: EditToDoCustomColumn(
                                    isEditing: false,
                                    isContainer: true,
                                    title: "Project".tr(),
                                    data: Container(
                                      decoration: ShapeDecoration(
                                        color:
                                            todo.project?.color.color
                                                .withValues(alpha: 0.125) ??
                                            AppColors.kProjectIconColor1
                                                .withValues(alpha: 0.125),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0,
                                          ),
                                          child: Text(
                                            todo.project?.name ?? "No Project",
                                            style: TextStyle(
                                              color:
                                                  todo.project?.color.color ??
                                                  AppColors.kProjectIconColor1,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                    icon: Iconsax.folder_24,
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .4,
                                  child: EditToDoCustomColumn(
                                    isEditing: false,
                                    isContainer: false,
                                    title: "Created".tr(),
                                    data: Text(
                                      DateFormat(
                                        'EEEE, MMMM d,\ny',
                                        context.locale.toString(),
                                      ).format(todo.createdAt),
                                      style: TextStyle(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    icon: Iconsax.calendar,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(20),
                            Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .4,
                                  child: Text(
                                    "Subtasks".tr(),
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .4,
                                  child: Text(
                                    "${todo.subtasks?.where((e) => e.isCompleted).length}/${todo.subtasks?.length ?? 0} ${"completed".tr()}",
                                  ),
                                ),
                              ],
                            ),
                            const Gap(5),
                            if (todo.subtasks?.isEmpty ?? true)
                              Text("No subtasks".tr())
                            else
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: todo.subtasks!.length,
                                itemBuilder: (context, index) {
                                  final subtask = todo.subtasks![index];
                                  return SizedBox(
                                    height: 40,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 20,
                                          child: Checkbox(
                                            value: subtask.isCompleted,
                                            onChanged: (value) {
                                              log(value.toString());
                                              context
                                                  .read<TodosCubit>()
                                                  .updateSubtaskStatus(
                                                    subtask,
                                                    value!,
                                                    todo,
                                                  );
                                            },
                                          ),
                                        ),
                                        const Gap(5),
                                        Text(
                                          subtask.title,
                                          style: TextStyle(
                                            decoration: subtask.isCompleted
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none,
                                          ),
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          icon: SvgPicture.asset(
                                            "assets/svgs/trash.svg",
                                            height: 20,
                                            colorFilter: const ColorFilter.mode(
                                              Colors.red,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                          onPressed: () {
                                            context
                                                .read<TodosCubit>()
                                                .deleteSubtask(todo, subtask);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

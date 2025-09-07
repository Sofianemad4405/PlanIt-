import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:planitt/core/entities/subtask_entity.dart';
import 'package:planitt/core/entities/to_do_entity.dart';
import 'package:planitt/core/entities/project_entity.dart';
import 'package:planitt/core/theme/app_colors.dart';
import 'package:planitt/core/utils/constants.dart';
import 'package:planitt/core/utils/extention.dart';
import 'package:planitt/core/widgets/add_todo_dialog.dart';
import 'package:planitt/core/widgets/task_search_field.dart';
import 'package:planitt/features/home/presentation/cubit/todos_cubit.dart';
import 'package:planitt/features/home/presentation/widgets/eidt_data_custom_column.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planitt/features/projects/data/models/project_model.dart';

class TodoEditingDialog extends StatefulWidget {
  const TodoEditingDialog({super.key, required this.toDo});
  final ToDoEntity toDo;

  @override
  State<TodoEditingDialog> createState() => _TodoEditingDialogState();
}

class _TodoEditingDialogState extends State<TodoEditingDialog> {
  // bool isEditing = false;
  TextEditingController newTitle = TextEditingController();
  TextEditingController newDesc = TextEditingController();
  ProjectEntity? newProject;
  late String newPriority;
  late DateTime newDueDate;
  late List<SubtaskEntity> newSubtasks;

  final _formKey = GlobalKey<FormState>();
  List<ProjectEntity> projects = [];
  @override
  void initState() {
    super.initState();
    _loadProjectsAndInitializeNewVars();
  }

  _loadProjectsAndInitializeNewVars() {
    final box = Hive.box<ProjectModel>(projectsBoxName);
    newProject = widget.toDo.project ?? ProjectEntity.defaultProject();
    newPriority = widget.toDo.priority;
    newDueDate = widget.toDo.dueDate ?? DateTime.now();
    newTitle.text = widget.toDo.title;
    newDesc.text = widget.toDo.description ?? "";
    newSubtasks = widget.toDo.subtasks ?? [];
    setState(() {
      projects = box.values.map((model) => model.toEntity()).toList();
      if (projects.isNotEmpty) {
        final match = projects.firstWhere(
          (p) =>
              p.name == newProject?.name &&
              p.color == newProject?.color &&
              p.icon == newProject?.icon,
          orElse: () => projects.first,
        );
        newProject = match;
      }
    });
  }

  TextEditingController subtask = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxW = constraints.maxWidth.clamp(280.0, 560.0);
            final maxH = constraints.maxHeight.clamp(
              200.0,
              MediaQuery.of(context).size.height * 0.8,
            );
            return ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxW, maxHeight: maxH),
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // title row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/svgs/edit.svg",
                              height: 20,
                              width: 20,
                            ),
                            const Gap(10),
                            Expanded(
                              child: TextFormField(
                                controller: newTitle,
                                decoration: InputDecoration(
                                  fillColor: Theme.of(
                                    context,
                                  ).colorScheme.surface,
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          Theme.of(context)
                                              .inputDecorationTheme
                                              .enabledBorder
                                              ?.borderSide
                                              .color ??
                                          Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final newToDo = ToDoEntity(
                                    key: widget.toDo.key,
                                    title: newTitle.text,
                                    description: newDesc.text,
                                    createdAt: widget.toDo.createdAt,
                                    dueDate: newDueDate,
                                    subtasks: newSubtasks,
                                    priority: newPriority,
                                    project: newProject,
                                    isToday: isSameDay(
                                      newDueDate,
                                      DateTime.now(),
                                    ),
                                    isTomorrow: isSameDay(
                                      newDueDate,
                                      DateTime.now().add(
                                        const Duration(days: 1),
                                      ),
                                    ),
                                    isOverdue: newDueDate.isBefore(
                                      DateTime.now(),
                                    ),
                                  );
                                  context.read<TodosCubit>().updateTodo(
                                    widget.toDo.key,
                                    newToDo,
                                  );
                                  context.pop();
                                }
                              },
                              icon: const Icon(
                                Iconsax.tick_circle4,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        const Gap(10),

                        // description
                        Text(
                          "Description".tr(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Gap(10),
                        CustomTextField(
                          hint: "Description (Optional)".tr(),
                          prefixIcon: false,
                          isDesc: true,
                          controller: newDesc,
                        ),
                        const Gap(20),

                        // due date & priority
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .4,
                              child: EditToDoCustomColumn(
                                isEditing: true,
                                isContainer: false,
                                title: "Due Date".tr(),
                                data: Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width * .4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color:
                                          Theme.of(context)
                                              .inputDecorationTheme
                                              .enabledBorder
                                              ?.borderSide
                                              .color ??
                                          Colors.grey,
                                    ),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2100),
                                          ).then((value) {
                                            if (value != null) {
                                              setState(() {
                                                newDueDate = value;
                                              });
                                            }
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              "${newDueDate.month}/${newDueDate.day}/${newDueDate.year}",
                                            ),
                                            const Spacer(),
                                            Icon(
                                              Iconsax.calendar,
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.onSurface,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                icon: Iconsax.calendar,
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .4,
                              child: EditToDoCustomColumn(
                                isEditing: true,
                                isContainer: true,
                                title: "Priority".tr(),
                                data: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          Theme.of(context)
                                              .inputDecorationTheme
                                              .enabledBorder
                                              ?.borderSide
                                              .color ??
                                          Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child: DropdownButton<String>(
                                        value: newPriority,
                                        items: priorities.map((p) {
                                          return DropdownMenuItem(
                                            value: p,
                                            child: Text(p),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            newPriority = value!;
                                          });
                                        },
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

                        // project & created date
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .4,
                              child: EditToDoCustomColumn(
                                isEditing: true,
                                isContainer: true,
                                title: "Project".tr(),
                                data: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          Theme.of(context)
                                              .inputDecorationTheme
                                              .enabledBorder
                                              ?.borderSide
                                              .color ??
                                          Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child: DropdownButton<ProjectEntity>(
                                        value: newProject,
                                        items: projects.map((project) {
                                          return DropdownMenuItem(
                                            value: project,
                                            child: SizedBox(
                                              width: 50,
                                              child: Text(
                                                project.name,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            newProject = value!;
                                          });
                                        },
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
                                isEditing: true,
                                isContainer: false,
                                title: "Created".tr(),
                                data: Text(
                                  DateFormat(
                                    'E, MMMM d,y',
                                  ).format(widget.toDo.createdAt),
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

                        // subtasks header
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
                            BlocBuilder<TodosCubit, TodosState>(
                              builder: (context, state) {
                                if (state is TodosLoaded) {
                                  final todo = state.todos
                                      .where((e) => e.key == widget.toDo.key)
                                      .first;
                                  return SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .4,
                                    child: Text(
                                      "${todo.subtasks?.where((e) => e.isCompleted).length}/${todo.subtasks?.length ?? 0} completed",
                                    ),
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ],
                        ),
                        const Gap(5),

                        // subtasks list
                        BlocBuilder<TodosCubit, TodosState>(
                          builder: (context, state) {
                            if (state is TodosLoaded) {
                              final todo = state.todos
                                  .where((todo) => todo.key == widget.toDo.key)
                                  .first;
                              if (todo.subtasks?.isEmpty ?? true) {
                                return Text("No subtasks".tr());
                              }
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
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
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onSurface,
                                          ),
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          icon: SvgPicture.asset(
                                            "assets/svgs/trash.svg",
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
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                        const Gap(15),
                        // add subtask
                        TextFormField(
                          controller: subtask,
                          decoration: InputDecoration(
                            fillColor: Theme.of(context).colorScheme.surface,
                            suffixIcon: BlocBuilder<TodosCubit, TodosState>(
                              builder: (context, state) {
                                return IconButton(
                                  onPressed: () {
                                    if (state is TodosLoaded) {
                                      final todos = state.todos;
                                      final todo = todos.firstWhere(
                                        (todo) => todo.key == widget.toDo.key,
                                      );
                                      context.read<TodosCubit>().addSubtask(
                                        todo,
                                        SubtaskEntity(
                                          title: subtask.text,
                                          isCompleted: false,
                                          index: todo.subtasks!.length,
                                        ),
                                      );
                                      newSubtasks = todo.subtasks!
                                          .map((e) => e.copyWith())
                                          .toList();
                                      subtask.clear();
                                    }
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                  ),
                                );
                              },
                            ),
                            hintText: "Add a subtask...".tr(),
                            hintStyle: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    Theme.of(context)
                                        .inputDecorationTheme
                                        .enabledBorder
                                        ?.borderSide
                                        .color ??
                                    Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

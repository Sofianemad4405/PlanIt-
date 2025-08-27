import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
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
  late ProjectEntity newProject;
  late String newPriority;
  late DateTime newDueDate;

  final _formKey = GlobalKey<FormState>();
  List<ProjectEntity> projects = [];
  @override
  void initState() {
    super.initState();
    _loadProjectsAndInitializeNewVars();
  }

  _loadProjectsAndInitializeNewVars() {
    final box = Hive.box<ProjectModel>(projectsBoxName);
    newProject = widget.toDo.project;
    newPriority = widget.toDo.priority;
    newDueDate = widget.toDo.dueDate ?? DateTime.now();
    newTitle.text = widget.toDo.title;
    newDesc.text = widget.toDo.description ?? "";
    setState(() {
      projects = box.values.map((model) => model.toEntity()).toList();
      if (projects.isNotEmpty) {
        final match = projects.firstWhere(
          (p) =>
              p.name == newProject.name &&
              p.color == newProject.color &&
              p.icon == newProject.icon,
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
                decoration: const BoxDecoration(
                  color: Color(0xff111216),
                  borderRadius: BorderRadius.only(
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
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
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
                                    subtasks: widget.toDo.subtasks,
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
                        const Text(
                          "Description",
                          style: TextStyle(
                            color: DarkMoodAppColors.kUnSelectedItemColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Gap(10),
                        CustomTextField(
                          hint: "Description (Optional)",
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
                                title: "Due Date",
                                data: Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width * .4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: DarkMoodAppColors
                                          .kUnSelectedItemColor,
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
                                            const Icon(
                                              Iconsax.calendar,
                                              color:
                                                  DarkMoodAppColors.kWhiteColor,
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
                                title: "Priority",
                                data: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: DarkMoodAppColors
                                          .kTextFieldBorderSideColor,
                                    ),
                                    color: DarkMoodAppColors.kFillColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child: DropdownButton<String>(
                                        value: newPriority,
                                        items: ["Low", "Medium", "High"].map((
                                          p,
                                        ) {
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
                                title: "Project",
                                data: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: DarkMoodAppColors
                                          .kTextFieldBorderSideColor,
                                    ),
                                    color: DarkMoodAppColors.kFillColor,
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
                                            child: Text(project.name),
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
                                title: "Created",
                                data: Text(
                                  DateFormat(
                                    'EEEE, MMMM d,\ny',
                                  ).format(widget.toDo.createdAt),
                                  style: const TextStyle(
                                    color: DarkMoodAppColors.kWhiteColor,
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
                              child: const Text(
                                "Subtasks",
                                style: TextStyle(
                                  color: DarkMoodAppColors.kUnSelectedItemColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .4,
                              child: Text(
                                "${widget.toDo.subtasks?.where((e) => e.isCompleted).length}/${widget.toDo.subtasks?.length ?? 0} completed",
                              ),
                            ),
                          ],
                        ),
                        const Gap(5),

                        // subtasks list
                        if (widget.toDo.subtasks?.isEmpty ?? true)
                          const Text("No subtasks")
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.toDo.subtasks!.length,
                            itemBuilder: (context, index) {
                              final subtask = widget.toDo.subtasks![index];
                              return SizedBox(
                                height: 30,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                      child: Checkbox(
                                        value: subtask.isCompleted,
                                        onChanged: (value) {
                                          setState(() {
                                            subtask.isCompleted = value!;
                                          });
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
                                      icon: const Icon(
                                        Iconsax.trash,
                                        color: DarkMoodAppColors
                                            .kUnSelectedItemColor,
                                      ),
                                      onPressed: () {
                                        log(
                                          "deleting subtask ${subtask.index} ${widget.toDo.key}",
                                        );
                                        // TODO: delete logic
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),

                        // add subtask
                        TextFormField(
                          controller: subtask,
                          decoration: InputDecoration(
                            suffixIcon: Consumer(
                              builder: (context, ref, child) {
                                return IconButton(
                                  onPressed: () {
                                    if (subtask.text.isNotEmpty) {
                                      try {
                                        subtask.clear();
                                      } catch (e) {
                                        log(e.toString());
                                      }
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: DarkMoodAppColors.kSelectedItemColor,
                                  ),
                                );
                              },
                            ),
                            hintText: "Add a subtask...",
                            hintStyle: const TextStyle(
                              color: DarkMoodAppColors.kUnSelectedItemColor,
                            ),
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    DarkMoodAppColors.kTextFieldBorderSideColor,
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

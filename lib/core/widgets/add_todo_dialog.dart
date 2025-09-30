import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:planitt/core/entities/project_entity.dart';
import 'package:planitt/core/entities/to_do_entity.dart';
import 'package:planitt/core/services/prefs.dart';
import 'package:planitt/core/theme/app_colors.dart';
import 'package:planitt/core/utils/constants.dart';
import 'package:planitt/core/utils/extention.dart';
import 'package:planitt/core/widgets/save_or_cancel_button.dart';
import 'package:planitt/core/widgets/task_search_field.dart';
import 'package:planitt/features/home/presentation/widgets/custom_row.dart';
import 'package:planitt/features/projects/presentation/cubit/projects_cubit.dart';
import 'package:uuid/uuid.dart';

class AddTodoDialog extends StatefulWidget {
  const AddTodoDialog({
    super.key,
    required this.onSaved,
    required this.selectedDate,
    this.selectedProject,
  });
  final Function(ToDoEntity) onSaved;
  final DateTime selectedDate;
  final ProjectEntity? selectedProject;

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String selectedPriority = "Low";
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  ProjectEntity? selectedProject;
  late DateTime createdAt;
  late DateTime dueDate;

  @override
  void initState() {
    super.initState();
    selectedProject = widget.selectedProject;
    selectedDate = widget.selectedDate;
    createdAt = DateTime.now();
    dueDate = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constrains) {
            final maxW = constrains.maxWidth.clamp(280.0, 560.0);
            final maxH = constrains.maxHeight.clamp(
              200.0,
              MediaQuery.of(context).size.height * 0.8,
            );
            return ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxW, maxHeight: maxH),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
                width: width * 0.8,
                height: height * 0.46,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Add Task".tr(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () => context.pop(),
                              child: const Icon(Iconsax.close_square),
                            ),
                          ],
                        ),
                        const Gap(10),
                        CustomTextField(
                          hint: "Title".tr(),
                          prefixIcon: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter a title".tr();
                            }
                            return null;
                          },
                          controller: titleController,
                        ),
                        const Gap(10),
                        CustomTextField(
                          hint: "Description (Optional)".tr(),
                          prefixIcon: false,
                          isDesc: true,
                          controller: descriptionController,
                        ),
                        const Gap(20),
                        CustomRow(
                          mainIcon: const Icon(
                            Iconsax.calendar_1,
                            color: DarkMoodAppColors.kUnSelectedItemColor,
                          ),
                          smallIcon: const Icon(Iconsax.calendar_1, size: 16),
                          text:
                              "${selectedDate.day.toString()}/${selectedDate.month.toString()}/${selectedDate.year.toString()}",
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                            ).then((value) {
                              if (value != null) {
                                setState(() {
                                  selectedDate = value;
                                });
                              }
                            });
                          },
                        ),
                        const Gap(10),
                        Row(
                          children: [
                            // Priority selector
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    color: selectedPriority == "Low"
                                        ? AppColors.kLowPriorityColor
                                        : selectedPriority == "Medium"
                                        ? AppColors.kMediumPriorityColor
                                        : selectedPriority == "High"
                                        ? AppColors.kHighPriorityColor
                                        : selectedPriority == "Urgent"
                                        ? AppColors.kUrgentPriorityColor
                                        : AppColors.kAddTodoColor,
                                    selectedPriority == "Low"
                                        ? Iconsax.star
                                        : selectedPriority == "Medium"
                                        ? Iconsax.star_1
                                        : selectedPriority == "High"
                                        ? Iconsax.magic_star
                                        : selectedPriority == "Urgent"
                                        ? Iconsax.medal_star4
                                        : Iconsax.star,
                                  ),
                                  const Gap(5),
                                  Expanded(
                                    child: Container(
                                      height: 35.97,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Theme.of(context)
                                                  .inputDecorationTheme
                                                  .enabledBorder
                                                  ?.borderSide
                                                  .color ??
                                              Colors.grey,
                                        ),
                                        color: Theme.of(context).colorScheme.surface,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            value: selectedPriority,
                                            items: priorities.map((priority) {
                                              return DropdownMenuItem(
                                                value: priority,
                                                child: Text(
                                                  priority,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Theme.of(context).colorScheme.onSurface,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              if (value != null) {
                                                setState(() {
                                                  selectedPriority = value;
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(10),
                            Flexible(
                              child: Visibility(
                                visible: context
                                    .read<ProjectsCubit>()
                                    .projects
                                    .isNotEmpty,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Iconsax.flag,
                                      color: DarkMoodAppColors
                                          .kUnSelectedItemColor,
                                    ),
                                    const Gap(5),
                                    Container(
                                      height: 35.97,
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
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.surface,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                          ),
                                          child: DropdownButton<ProjectEntity>(
                                            isExpanded: true,
                                            value:
                                                context
                                                    .watch<ProjectsCubit>()
                                                    .projects
                                                    .contains(selectedProject)
                                                ? selectedProject
                                                : null,
                                            items: context
                                                .watch<ProjectsCubit>()
                                                .projects
                                                .map((project) {
                                                  return DropdownMenuItem(
                                                    value: project,
                                                    child: Flexible(
                                                      child: Text(
                                                        project.name,
                                                        style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .onSurface,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                  );
                                                })
                                                .toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                selectedProject = value!;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SaveOrCancelButton(
                              isCancel: true,
                              ontap: () => context.pop(),
                            ),
                            const Gap(10),
                            SaveOrCancelButton(
                              isCancel: false,
                              ontap: () {
                                if (_formKey.currentState!.validate()) {
                                  const uuid = Uuid();
                                  final toDo = ToDoEntity(
                                    key: uuid.v4(),
                                    title: titleController.text,
                                    description:
                                        descriptionController.text.isEmpty
                                        ? null
                                        : descriptionController.text,
                                    createdAt: createdAt,
                                    dueDate: selectedDate,
                                    subtasks: [],
                                    priority: selectedPriority,
                                    project: selectedProject,
                                    isToday: isSameDay(selectedDate, createdAt),
                                    isTomorrow: isSameDay(
                                      selectedDate,
                                      createdAt.add(const Duration(days: 1)),
                                    ),
                                    isOverdue: isBeforeByDay(
                                      selectedDate,
                                      createdAt,
                                    ),
                                  );
                                  widget.onSaved(toDo);
                                }
                              },
                            ),
                          ],
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

bool isSameDay(DateTime d1, DateTime d2) {
  return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
}

bool isBeforeByDay(DateTime selectedDate, DateTime createdAt) {
  final s = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
  final c = DateTime(createdAt.year, createdAt.month, createdAt.day);
  return s.isBefore(c);
}

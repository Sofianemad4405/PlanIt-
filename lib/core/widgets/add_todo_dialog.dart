import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:iconsax/iconsax.dart';
import 'package:planitt/core/adapters/color_model.dart';
import 'package:planitt/core/entities/project_entity.dart';
import 'package:planitt/core/entities/to_do_entity.dart';
import 'package:planitt/core/theme/app_colors.dart';
import 'package:planitt/core/utils/constants.dart';
import 'package:planitt/core/utils/extention.dart';
import 'package:planitt/core/widgets/save_or_cancel_button.dart';
import 'package:planitt/core/widgets/task_search_field.dart';
import 'package:planitt/features/home/presentation/widgets/custom_row.dart';
import 'package:planitt/features/projects/data/models/project_model.dart';
import 'package:uuid/uuid.dart';

class AddTodoDialog extends StatefulWidget {
  const AddTodoDialog({super.key, required this.onSaved});
  final Function(ToDoEntity) onSaved;

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String selectedPriority = "Low";
  ProjectEntity selectedProject = ProjectEntity(
    id: "",
    name: "Inbox",
    color: ColorModel(0xff4F46E5),
  );
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<ProjectEntity> projects = [];
  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    final box = await Hive.openBox<ProjectModel>(projectsBoxName);
    setState(() {
      projects = box.values.map((model) => model.toEntity()).toList();
      if (projects.isNotEmpty) {
        // Ensure the selected value references an instance from items
        final match = projects.firstWhere(
          (p) =>
              p.name == selectedProject.name &&
              p.color == selectedProject.color &&
              p.icon == selectedProject.icon,
          orElse: () => projects.first,
        );
        selectedProject = match;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff111216),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        width: 361.59,
        height: 406.88,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      "Add Task",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
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
                  hint: "Title",
                  prefixIcon: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a title";
                    }
                    return null;
                  },
                  controller: titleController,
                ),
                const Gap(10),
                CustomTextField(
                  hint: "Description (Optional)",
                  prefixIcon: false,
                  isDesc: true,
                  controller: descriptionController,
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomRow(
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
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(
                            Iconsax.flag,
                            color: DarkMoodAppColors.kUnSelectedItemColor,
                          ),
                          const Gap(5),
                          Expanded(
                            child: Container(
                              height: 35.97,
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
                                    value: projects.contains(selectedProject)
                                        ? selectedProject
                                        : null,
                                    items: projects.map((project) {
                                      return DropdownMenuItem(
                                        value: project,
                                        child: Text(project.name),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedProject = value!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(20),
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(
                            Iconsax.flag,
                            color: DarkMoodAppColors.kUnSelectedItemColor,
                          ),
                          const Gap(5),
                          Expanded(
                            child: Container(
                              height: 35.97,
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
                                    value: selectedPriority,
                                    items: priorities.map((priority) {
                                      return DropdownMenuItem(
                                        value: priority,
                                        child: Text(priority),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedPriority = value!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
                            description: descriptionController.text,
                            createdAt: DateTime.now(),
                            dueDate: selectedDate,
                            subtasks: [],
                            priority: selectedPriority,
                            project: ProjectEntity(
                              id: uuid.v4(),
                              name: selectedProject.name,
                              color: selectedProject.color,
                              icon: selectedProject.icon,
                            ),
                            isToday: isSameDay(selectedDate, DateTime.now()),
                            isTomorrow: isSameDay(
                              selectedDate,
                              DateTime.now().add(const Duration(days: 1)),
                            ),
                            isOverdue: selectedDate.isBefore(DateTime.now()),
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
  }
}

bool isSameDay(DateTime d1, DateTime d2) {
  return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
}

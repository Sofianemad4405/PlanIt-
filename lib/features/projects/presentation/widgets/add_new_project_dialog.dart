import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:planitt/core/adapters/color_model.dart';
import 'package:planitt/core/entities/project_entity.dart';
import 'package:planitt/core/theme/app_colors.dart';
import 'package:planitt/core/utils/constants.dart';
import 'package:planitt/core/utils/extention.dart';
import 'package:planitt/core/widgets/save_or_cancel_button.dart';
import 'package:planitt/core/widgets/task_search_field.dart';
import 'package:planitt/features/projects/presentation/cubit/projects_cubit.dart';

class AddNewProjectDialog extends StatefulWidget {
  const AddNewProjectDialog({super.key});

  @override
  State<AddNewProjectDialog> createState() => _AddNewProjectDialogState();
}

class _AddNewProjectDialogState extends State<AddNewProjectDialog> {
  TextEditingController projectNameController = TextEditingController();
  ColorModel selectedColor = DarkMoodAppColors.kProjectIconColors[0];
  String selectedIcon = projectsIcons[0];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        width: 361.59,
        height: 500,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Add Project".tr(),
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
                const Gap(20),
                Text(
                  "Project name".tr(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const Gap(5),
                CustomTextField(
                  hint: "Enter project name".tr(),
                  prefixIcon: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a project name".tr();
                    }
                    return null;
                  },
                  controller: projectNameController,
                ),
                const Gap(20),
                Text(
                  "Project Color".tr(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const Gap(5),
                SizedBox(
                  height: 100,
                  child: GridView.builder(
                    // physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 1,
                          childAspectRatio: 1.3,
                        ),
                    itemCount: DarkMoodAppColors.kProjectIconColors.length,
                    itemBuilder: (context, index) {
                      final colorItem =
                          DarkMoodAppColors.kProjectIconColors[index];
                      final isSelected = selectedColor == colorItem;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedColor = colorItem;
                          });
                        },
                        child: Container(
                          padding: isSelected
                              ? const EdgeInsets.all(3)
                              : EdgeInsets.zero,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Theme.of(context).colorScheme.onSurface
                                : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: colorItem.color,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Text(
                  "Project Icon".tr(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const Gap(5),
                SizedBox(
                  height: 150,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 1,
                          childAspectRatio: 1.3,
                        ),
                    itemCount: projectsIcons.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIcon = projectsIcons[index];
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedIcon == projectsIcons[index]
                                ? Theme.of(context).colorScheme.onSurface
                                : Colors.transparent,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              projectsIcons[index],
                              style: TextStyle(
                                color: selectedIcon == projectsIcons[index]
                                    ? Theme.of(context).colorScheme.onSurface
                                    : Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SaveOrCancelButton(
                      ontap: () {
                        context.pop();
                      },
                      isCancel: true,
                    ),
                    const Gap(10),
                    SaveOrCancelButton(
                      ontap: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<ProjectsCubit>().addProject(
                            ProjectEntity(
                              id: context
                                  .read<ProjectsCubit>()
                                  .projects
                                  .length
                                  .toString(),
                              name: projectNameController.text,
                              color: selectedColor,
                              icon: selectedIcon,
                              todos: [],
                            ),
                          );
                          context.pop();
                        }
                      },
                      isCancel: false,
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

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:planitt/core/entities/project_entity.dart';
import 'package:planitt/core/theme/app_numbers.dart';
import 'package:planitt/features/projects/presentation/cubit/projects_cubit.dart';

class ProjectContainer extends StatelessWidget {
  const ProjectContainer({super.key, required this.project});
  final ProjectEntity project;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.1,
      width: width * 0.5,
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: project.color.color, width: 4)),
        borderRadius: BorderRadius.circular(AppNumbers.kEight),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  project.icon ?? "",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 16,
                  ),
                ),
                const Gap(5),
                SizedBox(
                  width: width * .2,
                  child: Text(
                    project.name.tr(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),

                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                PopupMenuButton<String>(
                  icon: Icon(
                    Icons.more_horiz,
                    color: Theme.of(context).colorScheme.onSurface,
                  ), // 3 dots
                  onSelected: (value) {
                    if (value == 'delete') {
                      context.read<ProjectsCubit>().deleteProject(project);
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(const SnackBar(content: Text("Deleted")));
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      height: 20,
                      value: 'delete',
                      child: Row(
                        children: [
                          const Icon(Icons.delete, color: Colors.red),
                          const Gap(5),
                          Text("Delete".tr()),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              "${project.todos.length.toString()} ${"Tasks".tr()}",
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
          ],
        ),
      ),
    );
  }
}

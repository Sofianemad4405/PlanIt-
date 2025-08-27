import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:planitt/core/entities/project_entity.dart';
import 'package:planitt/core/theme/app_colors.dart';
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
        color: DarkMoodAppColors.kFillColor,
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
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const Gap(5),
                SizedBox(
                  width: width * .2,
                  child: Text(
                    project.name,
                    style: const TextStyle(color: Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                PopupMenuButton<String>(
                  icon: const Icon(
                    Icons.more_horiz,
                    color: DarkMoodAppColors.kWhiteColor,
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
                    const PopupMenuItem(
                      height: 20,
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          Gap(5),
                          Text("Delete"),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              "${project.todos.length.toString()} Tasks",
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

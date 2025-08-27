import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:planitt/core/theme/text_themes.dart';
import 'package:planitt/features/projects/presentation/cubit/projects_cubit.dart';
import 'package:planitt/features/projects/presentation/views/project_details_Page_view_body.dart';
import 'package:planitt/features/projects/presentation/views/projects_grid_view.dart';
import 'package:planitt/features/projects/presentation/widgets/add_new_project.dart';
import 'package:planitt/features/projects/presentation/widgets/add_new_project_dialog.dart';

class ProjectsPageViewBody extends StatefulWidget {
  const ProjectsPageViewBody({super.key});

  @override
  State<ProjectsPageViewBody> createState() => ProjectsPageViewBodyState();
}

class ProjectsPageViewBodyState extends State<ProjectsPageViewBody> {
  @override
  void initState() {
    loadProjects();
    super.initState();
  }

  Future<void> loadProjects() async {
    context.read<ProjectsCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const Gap(20),
            Row(
              children: [
                Text(
                  "Projects",
                  style: TextThemes.whiteMedium.copyWith(fontSize: 20.4),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => const AddNewProjectDialog(),
                    );
                  },
                  child: const AddNewProject(),
                ),
              ],
            ),
            const Gap(20),
            BlocConsumer<ProjectsCubit, ProjectsState>(
              builder: (context, state) {
                if (state is ProjectsLoaded) {
                  return ProjectsGridView(
                    projects: state.projects,
                    onTap: (project) {
                      context.read<ProjectsCubit>().viewProjectDetails(project);
                    },
                  );
                } else if (state is ProjectsDetailsViewing) {
                  return ProjectDetailsPageViewBody(project: state.project);
                }
                return const SizedBox();
              },
              listener: (context, state) {
                if (state is ProjectsError) {
                  log(state.error);
                }
              },
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:planitt/core/theme/text_themes.dart';
import 'package:planitt/core/utils/extention.dart';
import 'package:planitt/features/projects/presentation/cubit/projects_cubit.dart';
import 'package:planitt/features/projects/presentation/views/project_details_Page_view_body.dart';
import 'package:planitt/features/projects/presentation/views/projects_grid_view.dart';
import 'package:planitt/features/projects/presentation/widgets/add_new_project.dart';
import 'package:planitt/features/projects/presentation/widgets/add_new_project_dialog.dart';
import 'package:planitt/features/projects/presentation/widgets/no_projects.dart';

class ProjectsPageViewBody extends StatefulWidget {
  const ProjectsPageViewBody({super.key});

  @override
  State<ProjectsPageViewBody> createState() => ProjectsPageViewBodyState();
}

class ProjectsPageViewBodyState extends State<ProjectsPageViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  @override
  void initState() {
    loadProjects();
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _offsetAnimation =
        Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.fastEaseInToSlowEaseOut,
          ),
        );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> loadProjects() async {
    context.read<ProjectsCubit>().init();
  }

  bool isInProjectDetails = false;

  @override
  Widget build(BuildContext context) {
    isInProjectDetails = context.read<ProjectsCubit>().isInProjectDetailsPage;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SlideTransition(
          position: _offsetAnimation,
          child: Column(
            children: [
              const Gap(20),
              Row(
                children: [
                  Text(
                    "Projects".tr(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 20.4,
                      fontWeight: FontWeight.bold,
                    ),
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
                    if (state.projects.isEmpty) {
                      return NoProjects(
                        text: 'Start your first one and make it count!'.tr(),
                      );
                    } else {
                      log("projects");
                      return ProjectsGridView(
                        projects: state.projects,
                        onTap: (project) {
                          context.read<ProjectsCubit>().isInProjectDetailsPage =
                              true;
                          context.read<ProjectsCubit>().selectedProject =
                              project;
                          context.read<ProjectsCubit>().loadProjectsTodos(
                            project,
                          );
                        },
                      );
                    }
                  } else if (state is ProjectDetailsLoaded) {
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
      ),
    );
  }
}

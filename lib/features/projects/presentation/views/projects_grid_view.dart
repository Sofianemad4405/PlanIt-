import 'package:flutter/material.dart';
import 'package:planitt/core/entities/project_entity.dart';
import 'package:planitt/features/projects/presentation/widgets/project_container.dart';

class ProjectsGridView extends StatefulWidget {
  const ProjectsGridView({
    super.key,
    required this.projects,
    required this.onTap,
  });
  final List<ProjectEntity> projects;
  final Function(ProjectEntity project) onTap;

  @override
  State<ProjectsGridView> createState() => _ProjectsGridViewState();
}

class _ProjectsGridViewState extends State<ProjectsGridView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 5,
        childAspectRatio: 1.5,
      ),
      itemCount: widget.projects.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            widget.onTap(widget.projects[index]);
          },
          child: ProjectContainer(project: widget.projects[index]),
        );
      },
    );
  }
}

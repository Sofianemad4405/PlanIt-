import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:planitt/core/theme/text_themes.dart';
import 'package:planitt/features/projects/presentation/widgets/add_new_project.dart';
import 'package:planitt/features/projects/presentation/widgets/project_container.dart';

class ProjectsPageViewBody extends StatefulWidget {
  const ProjectsPageViewBody({super.key});

  @override
  State<ProjectsPageViewBody> createState() => ProjectsPageViewBodyState();
}

class ProjectsPageViewBodyState extends State<ProjectsPageViewBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Gap(20),
            Row(
              children: [
                Text(
                  "Projects",
                  style: TextThemes.whiteMedium.copyWith(fontSize: 20.4),
                ),
                Spacer(),
                AddNewProject(),
              ],
            ),
            Gap(30),
            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 2,
              ),
              children: const [
                ProjectContainer(),
                ProjectContainer(),
                ProjectContainer(),
                ProjectContainer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

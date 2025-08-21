import 'dart:ui';

import 'package:hive/hive.dart';
import 'package:planitt/core/utils/constants.dart';
import 'package:planitt/features/projects/data/models/project_model.dart';

Future<void> seedDefaultProjects() async {
  final projectBox = await Hive.openBox<ProjectModel>(projectsBoxName);
  if (projectBox.isEmpty) {
    await projectBox.addAll([
      ProjectModel(name: "Inbox", color: const Color(0xff4F46E5), id: "1"),
      ProjectModel(name: "Personal", color: const Color(0xff4F46E5), id: "2"),
      ProjectModel(name: "Work", color: const Color(0xff4F46E5), id: "3"),
    ]);
  }
}

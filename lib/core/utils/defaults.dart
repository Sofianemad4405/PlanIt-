// import 'package:hive/hive.dart';
// import 'package:planitt/core/adapters/color_model.dart';
// import 'package:planitt/core/utils/constants.dart';
// import 'package:planitt/features/projects/data/models/project_model.dart';

// Future<void> seedDefaultProjects() async {
//   final projectBox = await Hive.openBox<ProjectModel>(projectsBoxName);
//   if (projectBox.isEmpty) {
//     await projectBox.addAll([
//       ProjectModel(name: "Inbox", color: ColorModel(0xff4F46E5), id: "1", todos: []),
//       ProjectModel(name: "Personal", color: ColorModel(0xff4F46E5), id: "2", todos: []),
//       ProjectModel(name: "Work", color: ColorModel(0xff4F46E5), id: "3", todos: []),
//     ]);
//   }
// }

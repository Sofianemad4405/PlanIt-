import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planitt/app/my_app.dart';
import 'package:planitt/core/models/to_do_model.dart';
import 'package:planitt/core/services/hive_storage_service.dart';
import 'package:hive/hive.dart';
import 'package:planitt/core/utils/constants.dart';
import 'package:planitt/core/utils/defaults.dart';
import 'package:planitt/features/projects/data/models/project_model.dart';
import 'package:planitt/core/adapters/color_adapter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init hive (via your service)
  await HiveServiceImpl().init();

  // register adapters
  Hive.registerAdapter(ToDoModelAdapter());
  Hive.registerAdapter(ProjectModelAdapter());
  Hive.registerAdapter(ColorAdapter());

  // open your box
  await Hive.openBox<ToDoModel>(todosBoxName);
  await Hive.openBox<ProjectModel>(projectsBoxName);

  await seedDefaultProjects();
  runApp(const ProviderScope(child: MyApp()));
}

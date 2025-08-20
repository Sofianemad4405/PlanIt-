import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planitt/app/my_app.dart';
import 'package:planitt/core/models/to_do_model.dart';
import 'package:planitt/core/services/hive_storage_service.dart';
import 'package:hive/hive.dart';
import 'package:planitt/core/utils/constants.dart';

void main() async {
  //init hive
  HiveServiceImpl().init();
  WidgetsFlutterBinding.ensureInitialized();
  // register adapters
  Hive.registerAdapter(ToDoModelAdapter());

  // open your box
  await Hive.openBox<ToDoModel>(todosBoxName);
  runApp(ProviderScope(child: const MyApp()));
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planitt/app/my_app.dart';
import 'package:planitt/core/services/hive_storage_service.dart';
import 'package:planitt/core/utils/defaults.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init hive (via your service)
  await HiveServiceImpl().init();
  await seedDefaultProjects();
  runApp(const ProviderScope(child: MyApp()));
}

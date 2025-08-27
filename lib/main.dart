import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planitt/app/my_app.dart';
import 'package:planitt/core/services/get_it_service.dart';
import 'package:planitt/core/services/hive_storage_service.dart';
import 'package:planitt/features/home/presentation/cubit/todos_cubit.dart';
import 'package:planitt/features/projects/presentation/cubit/projects_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init hive (via your service)
  await HiveServiceImpl().init();
  setupServiceLocator();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<TodosCubit>()..init()),
        BlocProvider(create: (context) => sl<ProjectsCubit>()..init()),
      ],
      child: const MyApp(),
    ),
  );
}

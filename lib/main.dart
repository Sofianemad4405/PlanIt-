import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planitt/app/controllers/theme_controller.dart';
import 'package:planitt/app/screens/splash.dart';
import 'package:planitt/app/themes/app_theme.dart';
import 'package:planitt/core/services/app_router.dart';
import 'package:planitt/core/services/get_it_service.dart';
import 'package:planitt/core/services/hive_storage_service.dart';
import 'package:planitt/features/home/presentation/cubit/todos_cubit.dart';
import 'package:planitt/features/projects/presentation/cubit/projects_cubit.dart';
import 'package:easy_localization/easy_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveServiceImpl().init();
  await EasyLocalization.ensureInitialized();
  setupServiceLocator();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translation',
      fallbackLocale: const Locale('en'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<ThemeCubit>()),
          BlocProvider(create: (context) => sl<TodosCubit>()..init()),
          BlocProvider(create: (context) => sl<ProjectsCubit>()..init()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          onGenerateRoute: AppRouter.generateRoute,
          debugShowCheckedModeBanner: false,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          darkTheme: AppTheme.dark(context),
          theme: AppTheme.light(context),
          themeMode: context.watch<ThemeCubit>().state,
          home: const Splash(),
        );
      },
    );
  }
}

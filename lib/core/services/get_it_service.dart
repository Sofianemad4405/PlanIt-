import 'package:get_it/get_it.dart';
import 'package:planitt/app/controllers/theme_controller.dart';
import 'package:planitt/core/services/hive_storage_service.dart';
import 'package:planitt/core/services/prefs.dart';
import 'package:planitt/features/home/data/data_sources/home_data_source.dart';
import 'package:planitt/features/home/data/repos/home_todos_repo_impl.dart';
import 'package:planitt/features/home/domain/repos/home_todos_repo.dart';
import 'package:planitt/features/home/presentation/cubit/todos_cubit.dart';
import 'package:planitt/features/projects/data/data_sources/projects_data_source.dart';
import 'package:planitt/features/projects/data/repos/projects_repo_impl.dart';
import 'package:planitt/features/projects/domain/repos/projects_repo.dart';
import 'package:planitt/features/projects/presentation/cubit/projects_cubit.dart';

final sl = GetIt.instance; // sl = service locator

void setupServiceLocator() {
  sl.registerLazySingleton<HomeDataSource>(
    () => HomeDataSourceImpl(sl<HiveServiceImpl>()),
  );
  sl.registerLazySingleton<ProjectsDataSource>(
    () => ProjectsDataSourceImpl(sl<HiveServiceImpl>()),
  );
  sl.registerLazySingleton<HiveServiceImpl>(() => HiveServiceImpl());
  sl.registerLazySingleton<PreferencesService>(() => PreferencesService());
  sl.registerLazySingleton<HomeTodosRepo>(
    () => HomeTodosRepoImpl(sl<HomeDataSource>()),
  );
  sl.registerLazySingleton<ProjectsRepo>(
    () => ProjectsRepoImpl(sl<ProjectsDataSource>()),
  );

  sl.registerFactory<TodosCubit>(() => TodosCubit(sl<HomeTodosRepo>()));
  sl.registerFactory<ProjectsCubit>(
    () => ProjectsCubit(
      sl<ProjectsRepo>(),
      sl<HomeTodosRepo>(),
      sl<TodosCubit>(),
    ),
  );
  sl.registerFactory<ThemeCubit>(() => ThemeCubit());
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planitt/core/entities/to_do_entity.dart';
import 'package:planitt/core/services/abstract_storage_service.dart';
import 'package:planitt/core/services/hive_storage_service.dart';
import 'package:planitt/features/home/data/data_sources/home_data_source.dart';
import 'package:planitt/features/home/data/repos/home_todos_repo_impl.dart';
import 'package:planitt/features/home/domain/repos/home_todos_repo.dart';
import 'package:planitt/features/home/presentation/riverpod/home_todo_notifier.dart';

final storageServiceProvider = Provider<AbstractStorageService>((ref) {
  return HiveServiceImpl();
});

final homeDataSourceProvider = Provider<HomeDataSource>((ref) {
  final storage = ref.watch(storageServiceProvider);
  return HomeDataSourceImpl(storage);
});

final homeTodosRepoProvider = Provider<HomeTodosRepo>((ref) {
  final dataSource = ref.watch(homeDataSourceProvider);
  return HomeTodosRepoImpl(dataSource);
});

final todosControllerProvider =
    StateNotifierProvider<HomeTodoNotifier, AsyncValue<List<ToDoEntity>>>((
      ref,
    ) {
      final repo = ref.watch(homeTodosRepoProvider);
      return HomeTodoNotifier(repo);
    });

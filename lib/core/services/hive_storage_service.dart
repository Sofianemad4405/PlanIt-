import 'package:hive_flutter/adapters.dart';
import 'package:planitt/core/adapters/color_model.dart';
import 'package:planitt/core/models/to_do_model.dart';
import 'package:planitt/core/services/abstract_storage_service.dart';
import 'package:planitt/core/utils/constants.dart';
import 'package:planitt/features/projects/data/models/project_model.dart';

class HiveServiceImpl implements AbstractStorageService {
  @override
  Future<void> init() async {
    await Hive.initFlutter();

    // register adapters
    Hive.registerAdapter(ToDoModelAdapter());
    Hive.registerAdapter(ProjectModelAdapter());
    Hive.registerAdapter(ColorModelAdapter());

    await Hive.openBox<ToDoModel>(todosBoxName);
    await Hive.openBox<ProjectModel>(projectsBoxName);
  }

  @override
  Future<void> addItem<T>({required String boxName, required T value}) async {
    final box = Hive.box<T>(boxName);
    await box.add(value);
  }

  @override
  Future<List<T>> getAll<T>({required String boxName}) async {
    final box = Hive.box<T>(boxName);
    return box.values.toList();
  }

  @override
  Future<void> delete({required String boxName, required String key}) async {
    final box = Hive.box(boxName);
    await box.delete(key);
  }

  @override
  Future<void> clear({required String boxName}) async {
    final box = Hive.box(boxName);
    await box.clear();
  }

  @override
  Future<void> update<T>({
    required String boxName,
    required String key,
    required T value,
  }) async {
    final box = Hive.box<T>(boxName);
    await box.put(key, value);
  }
}

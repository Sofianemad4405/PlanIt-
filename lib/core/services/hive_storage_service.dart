import 'package:hive_flutter/adapters.dart';
import 'package:planitt/core/models/subtask_model.dart';
import 'package:planitt/core/models/to_do_model.dart';
import 'package:planitt/core/services/abstract_storage_service.dart';
import 'package:planitt/core/utils/constants.dart';
import 'package:planitt/features/projects/data/models/project_model.dart';
import 'package:planitt/core/adapters/color_model.dart';

class HiveServiceImpl implements AbstractStorageService {
  @override
  Future<void> init() async {
    await Hive.initFlutter();

    // register adapters
    Hive.registerAdapter(ToDoModelAdapter());
    Hive.registerAdapter(ProjectModelAdapter());
    Hive.registerAdapter(ColorModelAdapter());
    Hive.registerAdapter(SubtaskModelAdapter());

    await Hive.openBox<ToDoModel>(todosBoxName);
    await Hive.openBox<ProjectModel>(projectsBoxName);
    await Hive.openBox<SubtaskModel>(subtasksBoxName);
  }

  Box<T> _getBox<T>(String boxName) {
    return Hive.box<T>(boxName);
  }

  @override
  Future<void> addItem<T>({required String boxName, required T value}) async {
    final box = _getBox<T>(boxName);

    if (value is ToDoModel) {
      // نستخدم الـ key كـ hiveKey عشان يبقى سهل نعمل update/delete بعدين
      await (box as Box<ToDoModel>).put(value.key, value);
    } else if (value is ProjectModel) {
      await (box as Box<ProjectModel>).put(value.id, value);
    } else if (value is SubtaskModel) {
      await (box as Box<SubtaskModel>).put(value.key, value);
    } else {
      await box.add(value);
    }
  }

  @override
  Future<List<T>> getAll<T>({required String boxName}) async {
    final box = _getBox<T>(boxName);
    return box.values.cast<T>().toList();
  }

  @override
  Future<void> delete({required String boxName, required String key}) async {
    if (boxName == projectsBoxName) {
      final box = Hive.box<ProjectModel>(boxName);
      await box.delete(key);
    } else if (boxName == todosBoxName) {
      final box = Hive.box<ToDoModel>(boxName);
      await box.delete(key);
    } else if (boxName == subtasksBoxName) {
      final box = Hive.box<SubtaskModel>(boxName);
      await box.delete(key);
    }
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
    final box = _getBox<T>(boxName);

    if (value is ToDoModel) {
      await (box as Box<ToDoModel>).put(key, value);
    } else if (value is ProjectModel) {
      await (box as Box<ProjectModel>).put(key, value);
    } else if (value is SubtaskModel) {
      await (box as Box<SubtaskModel>).put(key, value);
    } else {
      await box.put(key, value);
    }
  }
}

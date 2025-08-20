import 'package:hive_flutter/adapters.dart';
import 'package:planitt/core/services/abstract_storage_service.dart';

class HiveServiceImpl implements AbstractStorageService {
  @override
  Future<void> init() async {
    await Hive.initFlutter();
  }

  @override
  Future<void> addItem<T>({required String boxName, required T value}) async {
    final box = await Hive.openBox<T>(boxName);
    await box.add(value);
  }

  @override
  Future<List<T>> getAll<T>({required String boxName}) async {
    final box = await Hive.openBox<T>(boxName);
    return box.values.toList();
  }

  @override
  Future<void> delete({required String boxName, required int key}) async {
    final box = await Hive.openBox(boxName);
    await box.delete(key);
  }

  @override
  Future<void> clear({required String boxName}) async {
    final box = await Hive.openBox(boxName);
    await box.clear();
  }

  @override
  Future<void> update<T>({
    required String boxName,
    required int key,
    required T value,
  }) async {
    final box = await Hive.openBox<T>(boxName);
    await box.put(key, value);
  }
}

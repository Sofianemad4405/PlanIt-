import 'package:hive_flutter/adapters.dart';
import 'package:planitt/core/services/abstract_storage_service.dart';

class HiveServiceImpl implements AbstractStorageService {
  @override
  Future<void> init() async {
    await Hive.initFlutter();
  }

  @override
  Future<void> add<T>({
    required String boxName,
    required String key,
    required T value,
  }) async {
    final box = await Hive.openBox<T>(boxName);
    await box.put(key, value);
  }

  @override
  Future<T?> get<T>({required String boxName, required String key}) async {
    final box = await Hive.openBox<T>(boxName);
    return box.get(key);
  }

  @override
  Future<void> delete({required String boxName, required String key}) async {
    final box = await Hive.openBox(boxName);
    await box.delete(key);
  }

  @override
  Future<void> clear({required String boxName}) async {
    final box = await Hive.openBox(boxName);
    await box.clear();
  }
}

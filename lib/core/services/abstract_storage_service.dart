abstract class AbstractStorageService {
  Future<void> init();
  Future<void> add<T>({
    required String boxName,
    required String key,
    required T value,
  });
  Future<T?> get<T>({required String boxName, required String key});
  Future<void> delete({required String boxName, required String key});
  Future<void> clear({required String boxName});
}

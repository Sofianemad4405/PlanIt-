abstract class AbstractStorageService {
  Future<void> init();
  Future<void> addItem<T>({required String boxName, required T value});
  Future<List<T>> getAll<T>({required String boxName});
  Future<void> delete({required String boxName, required int key});
  Future<void> update<T>({
    required String boxName,
    required int key,
    required T value,
  });
  Future<void> clear({required String boxName});
}

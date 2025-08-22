import 'package:planitt/core/models/to_do_model.dart';
import 'package:planitt/core/services/abstract_storage_service.dart';
import 'package:planitt/core/utils/constants.dart';

abstract class HomeDataSource {
  Future<List<ToDoModel>> getTodayTodos();
  Future<List<ToDoModel>> getUpcomingTodos();
  Future<List<ToDoModel>> getAllTodos();
  Future<List<ToDoModel>> searchTodos(String query);
  Future<void> addTodo(ToDoModel toDo);
  Future<void> deleteTodo(ToDoModel toDo);
  Future<void> updateTodo(String key, ToDoModel toDo);
}

class HomeDataSourceImpl implements HomeDataSource {
  final AbstractStorageService storageService;
  HomeDataSourceImpl(this.storageService);

  @override
  Future<List<ToDoModel>> getTodayTodos() async {
    final todos = await storageService.getAll<ToDoModel>(boxName: todosBoxName);
    return todos
        .where(
          (t) =>
              t.dueDate != null &&
              t.dueDate!.day == DateTime.now().day &&
              t.dueDate!.month == DateTime.now().month &&
              t.dueDate!.year == DateTime.now().year,
        )
        .toList();
  }

  @override
  Future<List<ToDoModel>> getUpcomingTodos() async {
    final todos = await storageService.getAll<ToDoModel>(boxName: todosBoxName);
    return todos
        .where((t) => t.dueDate != null && t.dueDate!.isAfter(DateTime.now()))
        .toList();
  }

  @override
  Future<List<ToDoModel>> getAllTodos() async {
    return storageService.getAll<ToDoModel>(boxName: todosBoxName);
  }

  // @override
  // Future<List<ToDoModel>> getOverdueTodos() async {
  //   final todos = await storageService.getAll<ToDoModel>(boxName: todosBoxName);
  //   return todos
  //       .where((t) => t.dueDate != null && t.dueDate!.isBefore(DateTime.now()))
  //       .toList();
  // }

  @override
  Future<List<ToDoModel>> searchTodos(String query) async {
    final todos = await storageService.getAll<ToDoModel>(boxName: todosBoxName);
    return todos
        .where(
          (t) =>
              t.title.toLowerCase().contains(query.toLowerCase()) ||
              t.description!.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  @override
  Future<void> addTodo(ToDoModel toDo) async {
    await storageService.addItem(boxName: todosBoxName, value: toDo);
  }

  @override
  Future<void> deleteTodo(ToDoModel toDo) async {
    await storageService.delete(boxName: todosBoxName, key: toDo.key);
  }

  @override
  Future<void> updateTodo(String key, ToDoModel toDo) async {
    await storageService.update(
      boxName: todosBoxName,
      key: toDo.key,
      value: toDo,
    );
  }
}

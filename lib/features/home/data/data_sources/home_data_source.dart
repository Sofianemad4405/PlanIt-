import 'package:planitt/core/models/subtask_model.dart';
import 'package:planitt/core/models/to_do_model.dart';
import 'package:planitt/core/services/abstract_storage_service.dart';
import 'package:planitt/core/utils/constants.dart';

abstract class HomeDataSource {
  Future<List<ToDoModel>> getTodayTodos();
  Future<List<ToDoModel>> getUpcomingTodos();
  Future<List<ToDoModel>> getAllTodos();
  Future<List<ToDoModel>> getTaskByProjectId(String projectId);
  Future<List<ToDoModel>> searchTodos(String query);
  Future<List<ToDoModel>> filterTodos({
    List<String>? priorities,
    List<String>? projects,
  });
  Future<void> addTodo(ToDoModel toDo);
  Future<void> deleteTodo(ToDoModel toDo);
  Future<void> updateTodo(String key, ToDoModel toDo);
  Future<void> addSubtask(ToDoModel toDo, SubtaskModel subtask);
  Future<void> deleteSubtask(String todoKey, int subtaskIndex);
  Future<void> updateSubtask(
    String todoKey,
    int subtaskIndex,
    bool isCompleted,
  );
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
    return todos.where((t) {
      final titleMatch = t.title.toLowerCase().contains(query.toLowerCase());
      final descriptionMatch =
          t.description?.toLowerCase().contains(query.toLowerCase()) ?? false;
      return titleMatch || descriptionMatch;
    }).toList();
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

  @override
  Future<void> addSubtask(ToDoModel toDo, SubtaskModel subtask) async {
    await storageService.addItem(boxName: subtasksBoxName, value: subtask);
  }

  @override
  Future<void> deleteSubtask(String todoKey, int subtaskIndex) async {
    await storageService.delete(boxName: subtasksBoxName, key: todoKey);
  }

  @override
  Future<void> updateSubtask(
    String todoKey,
    int subtaskIndex,
    bool isCompleted,
  ) async {
    await storageService.update(
      boxName: subtasksBoxName,
      key: todoKey,
      value: isCompleted,
    );
  }

  @override
  Future<List<ToDoModel>> getTaskByProjectId(String projectId) async {
    final todos = await storageService.getAll<ToDoModel>(boxName: todosBoxName);
    return todos.where((t) => t.project.id == projectId).toList();
  }

  @override
  Future<List<ToDoModel>> filterTodos({
    List<String>? priorities,
    List<String>? projects,
  }) async {
    final todos = await storageService.getAll<ToDoModel>(boxName: todosBoxName);

    return todos.where((t) {
      final matchPriority = priorities == null || priorities.isEmpty
          ? true
          : priorities.contains(t.priority);

      final matchProject = projects == null || projects.isEmpty
          ? true
          : projects.contains(t.project.name);

      return matchPriority && matchProject;
    }).toList();
  }
}

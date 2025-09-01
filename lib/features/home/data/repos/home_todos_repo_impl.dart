import 'package:planitt/core/entities/subtask_entity.dart';
import 'package:planitt/core/entities/to_do_entity.dart';
import 'package:planitt/core/models/to_do_model.dart';
import 'package:planitt/features/home/data/data_sources/home_data_source.dart';
import 'package:planitt/features/home/domain/repos/home_todos_repo.dart';

class HomeTodosRepoImpl implements HomeTodosRepo {
  final HomeDataSource homeDataSource;
  HomeTodosRepoImpl(this.homeDataSource);

  @override
  Future<List<ToDoEntity>> getTodayTodos() async {
    final todos = await homeDataSource.getTodayTodos();
    return todos.map((todo) => todo.toEntity()).toList();
  }

  @override
  Future<List<ToDoEntity>> getUpcomingTodos() async {
    final todos = await homeDataSource.getUpcomingTodos();
    return todos.map((todo) => todo.toEntity()).toList();
  }

  @override
  Future<List<ToDoEntity>> getAllTodos() async {
    final todos = await homeDataSource.getAllTodos();
    return todos.map((todo) => todo.toEntity()).toList();
  }

  @override
  Future<List<ToDoEntity>> searchTodos(String query) async {
    final todos = await homeDataSource.searchTodos(query);
    return todos.map((todo) => todo.toEntity()).toList();
  }

  @override
  Future<void> addTodo(ToDoEntity toDo) async {
    await homeDataSource.addTodo(ToDoModel.fromEntity(toDo));
  }

  @override
  Future<void> deleteTodo(ToDoEntity toDo) async {
    await homeDataSource.deleteTodo(ToDoModel.fromEntity(toDo));
  }

  @override
  Future<void> updateTodo(String key, ToDoEntity toDo) async {
    await homeDataSource.updateTodo(key, ToDoModel.fromEntity(toDo));
  }

  @override
  Future<void> addSubtask(ToDoEntity toDo, SubtaskEntity subtask) async {
    // Build a new list of subtasks to avoid mutating the original reference
    final updatedSubtasks = List<SubtaskEntity>.from(toDo.subtasks ?? []);
    updatedSubtasks.add(subtask);

    // Create an updated ToDoEntity with the new subtasks list
    final updatedToDo = ToDoEntity(
      key: toDo.key,
      title: toDo.title,
      description: toDo.description,
      createdAt: toDo.createdAt,
      dueDate: toDo.dueDate,
      priority: toDo.priority,
      subtasks: updatedSubtasks,
      project: toDo.project,
      isToday: toDo.isToday,
      isTomorrow: toDo.isTomorrow,
      isOverdue: toDo.isOverdue,
      isFinished: toDo.isFinished,
    );
    await homeDataSource.updateTodo(
      updatedToDo.key,
      ToDoModel.fromEntity(updatedToDo),
    );
  }

  @override
  Future<void> deleteSubtask(String todoKey, SubtaskEntity subtask) async {
    await homeDataSource.deleteSubtask(todoKey, subtask.index);
  }

  @override
  Future<void> updateSubtask(String todoKey, SubtaskEntity subtask) async {
    await homeDataSource.updateSubtask(
      todoKey,
      subtask.index,
      subtask.isCompleted,
    );
  }

  @override
  Future<List<ToDoEntity>> getTaskByProjectId(String projectId) {
    return homeDataSource.getTaskByProjectId(projectId).then((todos) {
      return todos.map((todo) => todo.toEntity()).toList();
    });
  }

  @override
  Future<List<ToDoEntity>> filterTodos({
    List<String>? priorities,
    List<String>? projects,
  }) async {
    return await homeDataSource
        .filterTodos(priorities: priorities, projects: projects)
        .then((todo) => todo.map((todo) => todo.toEntity()).toList());
  }
}

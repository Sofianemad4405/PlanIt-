import 'package:planitt/core/entities/subtask_entity.dart';
import 'package:planitt/core/entities/to_do_entity.dart';

abstract class HomeTodosRepo {
  Future<List<ToDoEntity>> getTodayTodos();
  Future<List<ToDoEntity>> getUpcomingTodos();
  Future<List<ToDoEntity>> getAllTodos();
  Future<List<ToDoEntity>> getTaskByProjectId(String projectId);
  Future<List<ToDoEntity>> searchTodos(String query);
  Future<void> addTodo(ToDoEntity toDo);
  Future<void> deleteTodo(ToDoEntity toDo);
  Future<void> updateTodo(String key, ToDoEntity toDo);
  Future<void> addSubtask(ToDoEntity toDo, SubtaskEntity subtask);
  Future<void> deleteSubtask(String todoKey, SubtaskEntity subtask);
  Future<void> updateSubtask(String todoKey, SubtaskEntity subtask);
}

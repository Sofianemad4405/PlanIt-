import 'package:planitt/core/entities/to_do_entity.dart';

abstract class HomeTodosRepo {
  Future<List<ToDoEntity>> getTodayTodos();
  Future<List<ToDoEntity>> getUpcomingTodos();
  Future<List<ToDoEntity>> getAllTodos();
  Future<List<ToDoEntity>> searchTodos(String query);
  Future<void> addTodo(ToDoEntity toDo);
  Future<void> deleteTodo(ToDoEntity toDo);
  Future<void> updateTodo(String key, ToDoEntity toDo);
}

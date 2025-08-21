import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planitt/core/entities/to_do_entity.dart';
import 'package:planitt/features/home/domain/repos/home_todos_repo.dart';

class HomeTodoNotifier extends StateNotifier<AsyncValue<List<ToDoEntity>>> {
  final HomeTodosRepo repository;

  HomeTodoNotifier(this.repository) : super(const AsyncValue.loading()) {
    getAllTodos();
  }

  /// Get All Todos
  Future<void> getAllTodos() async {
    try {
      final todos = await repository.getAllTodos();
      state = AsyncValue.data(todos);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Get Today Todos
  Future<void> getTodayTodos() async {
    try {
      final todos = await repository.getTodayTodos();
      state = AsyncValue.data(todos);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Get Upcoming Todos
  Future<void> getUpcomingTodos() async {
    try {
      final todos = await repository.getUpcomingTodos();
      state = AsyncValue.data(todos);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Add Todo
  Future<void> addTodo(ToDoEntity todo) async {
    try {
      await repository.addTodo(todo);
      getAllTodos();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Update Todo
  Future<void> updateTodo(ToDoEntity todo) async {
    try {
      await repository.updateTodo(todo);
      getAllTodos();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Delete Todo
  Future<void> deleteTodo(ToDoEntity todo) async {
    try {
      await repository.deleteTodo(todo);
      getAllTodos();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

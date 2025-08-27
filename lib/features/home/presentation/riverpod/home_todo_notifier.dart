import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planitt/core/entities/subtask_entity.dart';
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
      state.whenData((todos) {
        state = AsyncValue.data([...todos, todo]);
      });
      getAllTodos(); // refresh from DB
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Update Todo
  Future<void> updateTodo(String key, ToDoEntity todo) async {
    try {
      await repository.updateTodo(key, todo);
      state.whenData((todos) {
        state = AsyncValue.data(
          todos.map((e) => e.key == key ? todo : e).toList(),
        );
      });
      getAllTodos();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Delete Todo
  Future<void> deleteTodo(ToDoEntity todo) async {
    try {
      await repository.deleteTodo(todo);
      state.whenData((todos) {
        state = AsyncValue.data(todos.where((e) => e.key != todo.key).toList());
      });
      getAllTodos();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Add Subtask
  Future<void> addSubtask(ToDoEntity toDo, SubtaskEntity subtask) async {
    try {
      await repository.addSubtask(toDo, subtask);
      state.whenData((todos) {
        state = AsyncValue.data(
          todos.map((e) => e.key == toDo.key ? toDo : e).toList(),
        );
      });
      getAllTodos();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Delete Subtask
  Future<void> deleteSubtask(String todoKey, SubtaskEntity subtask) async {
    try {
      await repository.deleteSubtask(todoKey, subtask);
      state.whenData((todos) {
        state = AsyncValue.data(
          todos
              .map(
                (e) => e.key == todoKey
                    ? e.copyWith(
                        subtasks: e.subtasks!
                            .where((s) => s.index != subtask.index)
                            .toList(),
                      )
                    : e,
              )
              .toList(),
        );
      });
      getAllTodos();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Update Subtask
  Future<void> updateSubtask(String todoKey, SubtaskEntity subtask) async {
    try {
      await repository.updateSubtask(todoKey, subtask);
      state.whenData((todos) {
        state = AsyncValue.data(
          todos
              .map(
                (e) => e.key == todoKey
                    ? e.copyWith(
                        subtasks: e.subtasks!
                            .map((s) => s.index == subtask.index ? subtask : s)
                            .toList(),
                      )
                    : e,
              )
              .toList(),
        );
      });
      getAllTodos();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

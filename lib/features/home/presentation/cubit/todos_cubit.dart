import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planitt/core/entities/subtask_entity.dart';
import 'package:planitt/core/entities/to_do_entity.dart';
import 'package:planitt/features/home/domain/repos/home_todos_repo.dart';

part 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  TodosCubit(this.repository) : super(TodosInitial());

  final HomeTodosRepo repository;
  List<ToDoEntity> todos = [];
  ToDoEntity? selectedTodo;
  void init() {
    getAllTodos();
  }

  Future<void> getAllTodos() async {
    try {
      emit(TodosLoading());
      todos = await repository.getAllTodos();
      emit(TodosLoaded(todos: todos));
    } catch (e) {
      emit(TodosError(error: e.toString()));
    }
  }

  Future<void> getTodayTodos() async {
    try {
      emit(TodosLoading());
      todos = await repository.getTodayTodos();
      emit(TodosLoaded(todos: todos));
    } catch (e) {
      emit(TodosError(error: e.toString()));
    }
  }

  Future<void> getUpcomingTodos() async {
    try {
      emit(TodosLoading());
      todos = await repository.getUpcomingTodos();
      emit(TodosLoaded(todos: todos));
    } catch (e) {
      emit(TodosError(error: e.toString()));
    }
  }

  Future<void> searchTodos(String query) async {
    try {
      emit(TodosLoading());
      todos = await repository.searchTodos(query);
      emit(TodosLoaded(todos: todos));
    } catch (e) {
      emit(TodosError(error: e.toString()));
    }
  }

  Future<void> addTodo(ToDoEntity todo) async {
    try {
      await repository.addTodo(todo);
      todos = [...todos, todo];
      emit(TodoAddedSuccess());
      emit(TodosLoaded(todos: todos));
    } catch (e) {
      emit(TodosError(error: e.toString()));
    }
  }

  Future<void> filterTodos({
    List<String>? priorities,
    List<String>? projects,
  }) async {
    try {
      emit(TodosLoading());
      todos = await repository.filterTodos(
        projects: projects,
        priorities: priorities,
      );
      emit(TodosLoaded(todos: todos));
    } catch (e) {
      emit(TodosError(error: e.toString()));
    }
  }

  List<ToDoEntity> getProjectTasks(String projectId) {
    return todos.where((t) => t.project?.id == projectId).toList();
  }

  Future<void> updateTodo(String key, ToDoEntity newTodo) async {
    try {
      await repository.updateTodo(key, newTodo);
      todos = todos.map((e) => e.key == key ? newTodo : e).toList();
      emit(TodosLoaded(todos: todos));
    } catch (e) {
      emit(TodosError(error: e.toString()));
    }
  }

  Future<void> deleteTodo(ToDoEntity todo) async {
    try {
      emit(TodoDeleting());
      await repository.deleteTodo(todo);
      todos = todos.where((e) => e.key != todo.key).toList();
      emit(TodosLoaded(todos: todos));
    } catch (e) {
      emit(TodosError(error: e.toString()));
    }
  }

  Future<void> deleteProjectTodos(String projectId) async {
    try {
      log("ytm mas7");
      await repository.deleteProjectTodos(projectId);
      log("tm mas7");
      todos = todos.where((e) => e.project?.id != projectId).toList();
      emit(TodosLoaded(todos: todos));
    } catch (e) {
      emit(TodosError(error: e.toString()));
    }
  }

  Future<void> addSubtask(ToDoEntity todo, SubtaskEntity subtask) async {
    try {
      await repository.addSubtask(todo, subtask);
      final updatedTodo = todo.copyWith(subtasks: [...?todo.subtasks, subtask]);
      todos = todos.map((e) => e.key == todo.key ? updatedTodo : e).toList();
      emit(TodosLoaded(todos: todos));
    } catch (e) {
      emit(TodosError(error: e.toString()));
    }
  }

  Future<void> deleteSubtask(ToDoEntity todo, SubtaskEntity subtask) async {
    try {
      await repository.deleteSubtask(todo.key, subtask);
      final updatedTodo = todo.copyWith(
        subtasks: todo.subtasks!..remove(subtask),
      );
      todos = todos.map((e) => e.key == todo.key ? updatedTodo : e).toList();
      emit(TodosLoaded(todos: todos));
    } catch (e) {
      emit(TodosError(error: e.toString()));
    }
  }

  Future<void> updateSubtaskStatus(
    SubtaskEntity subtask,
    bool isCompleted,
    ToDoEntity todo,
  ) async {
    try {
      final updatedSubtask = subtask.copyWith(isCompleted: isCompleted);
      await repository.updateSubtask(
        updatedSubtask.index.toString(),
        updatedSubtask,
      );

      final updatedTodo = todo.copyWith(
        subtasks: todo.subtasks!
            .map((e) => e.index == subtask.index ? updatedSubtask : e)
            .toList(),
      );

      todos = todos.map((e) => e.key == todo.key ? updatedTodo : e).toList();
      emit(TodosLoaded(todos: todos));
    } catch (e) {
      emit(TodosError(error: e.toString()));
    }
  }
}

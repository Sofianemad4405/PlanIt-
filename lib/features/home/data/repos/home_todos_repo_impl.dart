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
  Future<void> updateTodo(ToDoEntity toDo) async {
    await homeDataSource.updateTodo(ToDoModel.fromEntity(toDo));
  }
}

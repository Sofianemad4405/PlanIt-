import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
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
    emit(TodosSuccessHome(todos: todos));
  }

  Future<void> getAllTodos() async {
    todos = await repository.getAllTodos();
    emit(TodosSuccessHome(todos: todos));
  }

  Future<void> getTodayTodos() async {
    todos = await repository.getTodayTodos();
    emit(TodosSuccessHome(todos: todos));
  }

  Future<void> getUpcomingTodos() async {
    todos = await repository.getUpcomingTodos();
    emit(TodosSuccessHome(todos: todos));
  }

  Future<void> searchTodos(String query) async {
    todos = await repository.searchTodos(query);
    emit(TodosSuccessHome(todos: todos));
  }

  Future<void> addTodo(ToDoEntity todo) async {
    await repository.addTodo(todo);
    todos = [...todos, todo];
    emit(TodosSuccessHome(todos: todos));
  }

  Future<void> viewTodo(ToDoEntity todo) async {
    selectedTodo = todo;
    emit(TodosViewing(todo: todo));
  }

  Future<void> getTaskByProjectId(String projectId) async {
    todos = await repository.getTaskByProjectId(projectId);
    emit(TodosByProjectId(todos: todos));
  }

  Future<void> updateTodo(String key, ToDoEntity newTodo) async {
    await repository.updateTodo(key, newTodo);

    todos = todos.map((e) => e.key == key ? newTodo : e).toList();
    emit(TodosSuccessHome(todos: todos));
  }

  Future<void> deleteTodo(ToDoEntity todo) async {
    await repository.deleteTodo(todo);
    todos = todos.where((e) => e.key != todo.key).toList();
    emit(TodosSuccessHome(todos: todos));
  }
}

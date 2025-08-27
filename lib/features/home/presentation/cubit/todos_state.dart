part of 'todos_cubit.dart';

@immutable
sealed class TodosState {}

final class TodosInitial extends TodosState {}

final class TodosLoading extends TodosState {}

final class TodosSuccessHome extends TodosState {
  final List<ToDoEntity> todos;
  TodosSuccessHome({required this.todos});
}

final class TodosError extends TodosState {
  final String error;
  TodosError({required this.error});
}

final class TodosViewing extends TodosState {
  final ToDoEntity todo;
  TodosViewing({required this.todo});
}

final class TodosByProjectId extends TodosState {
  final List<ToDoEntity> todos;
  TodosByProjectId({required this.todos});
}

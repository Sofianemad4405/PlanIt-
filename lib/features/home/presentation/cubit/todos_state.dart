part of 'todos_cubit.dart';

@immutable
sealed class TodosState {}

final class TodosInitial extends TodosState {}

final class TodosLoading extends TodosState {}

final class TodosLoaded extends TodosState {
  final List<ToDoEntity> todos;
  TodosLoaded({required this.todos});
}

final class TodosError extends TodosState {
  final String error;
  TodosError({required this.error});
}

/// حالة لما todo واحد يتعرض للتفاصيل
final class TodoViewing extends TodosState {
  final ToDoEntity todo;
  TodoViewing({required this.todo});
}

/// حالة نجاح إضافة Todo
final class TodoAddedSuccess extends TodosState {}

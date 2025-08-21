import 'package:planitt/core/entities/to_do_entity.dart';
import 'package:planitt/features/home/domain/repos/home_todos_repo.dart';

class DeleteTodo {
  final HomeTodosRepo homeTodosRepo;

  DeleteTodo(this.homeTodosRepo);

  Future<void> call(ToDoEntity toDo) async {
    await homeTodosRepo.deleteTodo(toDo);
  }
}

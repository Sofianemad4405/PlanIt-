import 'package:planitt/core/entities/to_do_entity.dart';
import 'package:planitt/features/home/domain/repos/home_todos_repo.dart';

class AddTodo {
  final HomeTodosRepo homeTodosRepo;

  AddTodo(this.homeTodosRepo);

  Future<void> call(ToDoEntity toDo) async {
    await homeTodosRepo.addTodo(toDo);
  }
}

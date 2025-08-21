import 'package:planitt/core/entities/to_do_entity.dart';
import 'package:planitt/features/home/domain/repos/home_todos_repo.dart';

class GetAllTodos {
  final HomeTodosRepo homeTodosRepo;

  GetAllTodos(this.homeTodosRepo);

  Future<List<ToDoEntity>> call() async {
    return homeTodosRepo.getAllTodos();
  }
}

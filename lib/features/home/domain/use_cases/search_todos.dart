import 'package:planitt/core/entities/to_do_entity.dart';
import 'package:planitt/features/home/domain/repos/home_todos_repo.dart';

class SearchTodos {
  final HomeTodosRepo homeTodosRepo;

  SearchTodos(this.homeTodosRepo);

  Future<List<ToDoEntity>> call(String query) async {
    return homeTodosRepo.searchTodos(query);
  }
}

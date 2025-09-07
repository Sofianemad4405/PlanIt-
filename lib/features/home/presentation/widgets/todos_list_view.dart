import 'package:flutter/material.dart';
import 'package:planitt/core/entities/to_do_entity.dart';
import 'package:planitt/features/home/presentation/widgets/task_list_tile.dart';

class TodosListView extends StatelessWidget {
  const TodosListView({
    super.key,
    required this.todos,
    required this.onDelete,
    required this.onTileTab,
    required this.onTaskCompleted,
  });

  final List<ToDoEntity> todos;
  final Function(ToDoEntity) onDelete;
  final Function(ToDoEntity) onTileTab;
  final Function(ToDoEntity) onTaskCompleted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: TaskListtile(
              onTaskCompleted: () => onTaskCompleted(todo),
              toDo: todo,
              onDelete: () => onDelete(todo),
              onTileTab: () => onTileTab(todo),
            ),
          );
        },
      ),
    );
  }
}

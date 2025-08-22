import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planitt/core/entities/to_do_entity.dart';
import 'package:planitt/core/providers/providers.dart';
import 'package:planitt/features/home/presentation/widgets/edit_note_dialog.dart';
import 'package:planitt/features/home/presentation/widgets/task_list_tile.dart';

class TodosListView extends ConsumerWidget {
  const TodosListView({super.key, required this.todos});

  final List<ToDoEntity> todos;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: TaskListtile(
            toDo: todos[index],
            onDelete: () {
              ref
                  .read(todosControllerProvider.notifier)
                  .deleteTodo(todos[index]);
            },
            onTileTab: () {
              showDialog(
                context: context,
                builder: (context) {
                  return EditNoteDialog(toDo: todos[index]);
                },
              );
            },
          ),
        );
      },
      itemCount: todos.length,
    );
  }
}

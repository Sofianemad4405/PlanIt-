import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planitt/core/entities/to_do_entity.dart';
import 'package:planitt/core/providers/providers.dart';
import 'package:planitt/features/home/presentation/widgets/task_list_tile.dart';

class TodosListView extends ConsumerWidget {
  const TodosListView({super.key, required this.todos});

  final List<ToDoEntity> todos;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosControllerProvider);
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: TaskListtile(
            toDo: todos.value![index],
            onDelete: () {
              ref
                  .read(todosControllerProvider.notifier)
                  .deleteTodo(todos.value![index]);
            },
            onTileTab: () {},
          ),
        );
      },
      itemCount: todos.value?.length ?? 0,
    );
  }
}

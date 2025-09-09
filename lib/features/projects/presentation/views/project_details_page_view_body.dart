import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:planitt/core/entities/project_entity.dart';
import 'package:planitt/core/utils/extention.dart';
import 'package:planitt/core/widgets/add_todo_dialog.dart';
import 'package:planitt/features/home/presentation/cubit/todos_cubit.dart';
import 'package:planitt/features/home/presentation/widgets/task_list_tile.dart';
import 'package:planitt/features/home/presentation/widgets/todo_read_dialog.dart';
import 'package:planitt/features/projects/presentation/cubit/projects_cubit.dart';

class ProjectDetailsPageViewBody extends StatefulWidget {
  const ProjectDetailsPageViewBody({super.key, required this.project});
  final ProjectEntity project;

  @override
  State<ProjectDetailsPageViewBody> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPageViewBody> {
  @override
  void initState() {
    context.read<TodosCubit>().getProjectTasks(widget.project.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectsCubit, ProjectsState>(
      listener: (context, state) {
        if (state is ProjectDetailsLoaded) {
          context.read<TodosCubit>().getProjectTasks(widget.project.id);
        }
      },
      builder: (context, state) {
        if (state is ProjectDetailsLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  context.read<ProjectsCubit>().toggleProjectsPageState(
                    false,
                    widget.project,
                  );
                },
                child: Row(
                  children: [
                    const Icon(Icons.arrow_back, color: Color(0xFF4F46E5)),
                    const Gap(5),
                    Text(
                      "Back to Projects".tr(),
                      style: const TextStyle(color: Color(0xFF4F46E5)),
                    ),
                  ],
                ),
              ),
              const Gap(20),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Center(
                      child: Text(
                        widget.project.icon ?? "",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: Text(
                      widget.project.name,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const Gap(20),
              Text(
                "${"Tasks".tr()} (${state.project.todos.length})",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(20),
              state.project.todos.isEmpty
                  ? Center(
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AddTodoDialog(
                                selectedDate: DateTime.now(),
                                onSaved: (todo) {
                                  context.read<TodosCubit>().addTodo(todo);
                                  context
                                      .read<ProjectsCubit>()
                                      .loadProjectsTodos(widget.project);
                                  context.pop();
                                },
                                selectedProject: widget.project,
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 163.95,
                          width: 348.37,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.add,
                                color: Color(0xFF9CA3AF),
                                size: 40,
                              ),
                              const Gap(15),
                              Text(
                                "No Tasks Yet".tr(),
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Gap(10),
                              Text(
                                "Add tasks to this project".tr(),
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.project.todos.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: TaskListtile(
                            toDo: state.project.todos[index],
                            onDelete: () {
                              context.read<TodosCubit>().deleteTodo(
                                state.project.todos[index],
                              );
                              context.read<ProjectsCubit>().loadProjectsTodos(
                                state.project,
                              );
                            },
                            onTileTab: () {
                              try {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return TodoReadDialog(
                                      toDoKey: state.project.todos[index].key,
                                    );
                                  },
                                );
                              } catch (e) {
                                log(e.toString());
                              }
                            },
                          ),
                        );
                      },
                    ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

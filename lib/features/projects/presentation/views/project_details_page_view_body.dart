import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:planitt/core/entities/project_entity.dart';
import 'package:planitt/core/widgets/add_todo_dialog.dart';
import 'package:planitt/features/home/presentation/cubit/todos_cubit.dart';
import 'package:planitt/features/home/presentation/widgets/task_list_tile.dart';
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
    context.read<TodosCubit>().getTaskByProjectId(widget.project.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectsCubit, ProjectsState>(
      listener: (context, state) {
        if (state is TodosLoadedInProjectDetailsPage) {
          context.read<TodosCubit>().getTaskByProjectId(widget.project.id);
        }
      },
      builder: (context, state) {
        if (state is TodosLoadedInProjectDetailsPage) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  context.read<ProjectsCubit>().toggleProjectsPageState(
                    true,
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
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 101, 113, 133),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
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
                  Text(
                    widget.project.name,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
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
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Gap(10),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AddTodoDialog(
                                      onSaved: (todo) {
                                        context.read<TodosCubit>().addTodo(
                                          todo,
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              child: Text(
                                "Add tasks to this project".tr(),
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
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
                              // context.read<TodosCubit>().deleteTodo(
                              //   todos[index],
                              // );
                              context
                                  .read<ProjectsCubit>()
                                  .deleteTodoFromProject(
                                    state.project.todos[index],
                                    state.project,
                                  );
                            },
                            onTileTab: () {
                              context.read<TodosCubit>().viewTodo(
                                state.project.todos[index],
                              );
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

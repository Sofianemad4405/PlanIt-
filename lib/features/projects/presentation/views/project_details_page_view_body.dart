import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:planitt/core/entities/project_entity.dart';
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
    return BlocConsumer<TodosCubit, TodosState>(
      listener: (context, state) {
        if (state is TodosByProjectId) {
          // مش محتاج تنادي getTaskByProjectId تاني هنا
          // لأنه هيعمل loop مالوش لازمة
        }
      },
      builder: (context, state) {
        if (state is TodosByProjectId) {
          final todos = state.todos;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  context.read<ProjectsCubit>().getAllProjects();
                },
                child: const Row(
                  children: [
                    Icon(Icons.arrow_back, color: Color(0xFF4F46E5)),
                    Gap(5),
                    Text(
                      "Back to Projects",
                      style: TextStyle(color: Color(0xFF4F46E5)),
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
                      color: Color(0xFF374151),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Center(
                      child: Text(
                        widget.project.icon ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Text(
                    widget.project.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Gap(20),
              Text(
                "Tasks (${todos.length})",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(20),
              todos.isEmpty
                  ? Center(
                      child: Container(
                        height: 163.95,
                        width: 348.37,
                        decoration: const BoxDecoration(
                          color: Color(0xFF1F2937),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: Color(0xFF9CA3AF), size: 40),
                            Gap(15),
                            Text(
                              "No Tasks Yet",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(10),
                            Text(
                              "Add tasks to this project",
                              style: TextStyle(
                                color: Color(0xFF9CA3AF),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: TaskListtile(
                            toDo: todos[index],
                            onDelete: () {
                              context.read<TodosCubit>().deleteTodo(
                                todos[index],
                              );
                            },
                            onTileTab: () {
                              context.read<TodosCubit>().viewTodo(todos[index]);
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

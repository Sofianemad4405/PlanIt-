import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planitt/core/entities/project_entity.dart';
import 'package:planitt/core/theme/app_colors.dart';
import 'package:planitt/core/utils/extention.dart';
import 'package:planitt/core/widgets/add_todo_dialog.dart';
import 'package:planitt/core/widgets/custom_app_bar.dart';
import 'package:planitt/core/widgets/custom_nav_bar.dart';
import 'package:planitt/features/calender/presentation/views/calendar_page_view_body.dart';
import 'package:planitt/features/focus/presentation/views/focus_page_view_body.dart';
import 'package:planitt/features/home/presentation/cubit/todos_cubit.dart';
import 'package:planitt/features/home/presentation/views/home_page_view_body.dart';
import 'package:planitt/features/projects/presentation/cubit/projects_cubit.dart';
import 'package:planitt/features/projects/presentation/views/projects_page_view_body.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const CustomAppBar(),
      body: _currentIndex == 0
          ? const HomePageViewBody()
          : _currentIndex == 1
          ? const ProjectsPageViewBody()
          : _currentIndex == 2
          ? const CalendarPageViewBody()
          : _currentIndex == 3
          ? const FocusPageViewBody()
          : const HomePageViewBody(),
      bottomNavigationBar: CustomNavBar(
        currentIndex: _currentIndex,
        onItemTapped: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      floatingActionButton: BlocBuilder<TodosCubit, TodosState>(
        builder: (context, state) {
          return FloatingActionButton(
            shape: const CircleBorder(),
            onPressed: () {
              // context.read<ProjectsCubit>().init();
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) {
                  return AddTodoDialog(
                    onSaved: (todo) {
                      context.read<TodosCubit>().addTodo(todo);
                      if (_currentIndex == 1) {
                        context.read<ProjectsCubit>().loadProjectsTodos(
                          context.read<ProjectsCubit>().selectedProject ??
                              ProjectEntity.defaultProject(),
                        );
                      }
                      context.pop();
                    },
                  );
                },
              );
            },
            backgroundColor: DarkMoodAppColors.kSelectedItemColor,
            child: const Icon(Icons.add, color: AppColors.kWhiteColor),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planitt/core/providers/providers.dart';
import 'package:planitt/core/theme/app_colors.dart';
import 'package:planitt/core/utils/extention.dart';
import 'package:planitt/core/widgets/add_todo_dialog.dart';
import 'package:planitt/core/widgets/custom_app_bar.dart';
import 'package:planitt/core/widgets/custom_nav_bar.dart';
import 'package:planitt/features/calender/presentation/views/calendar_page_view_body.dart';
import 'package:planitt/features/focus/presentation/views/focus_page_view_body.dart';
import 'package:planitt/features/home/presentation/views/home_page_view_body.dart';
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
      floatingActionButton: Consumer(
        builder: (context, ref, child) {
          return FloatingActionButton(
            shape: const CircleBorder(),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) {
                  return AddTodoDialog(
                    onSaved: (todo) {
                      ref.read(todosControllerProvider.notifier).addTodo(todo);
                      context.pop();
                    },
                  );
                },
              );
            },
            backgroundColor: DarkMoodAppColors.kSelectedItemColor,
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }
}

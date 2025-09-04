import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:confetti/confetti.dart';
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
  ConfettiController _confettiController = ConfettiController(
    duration: const Duration(seconds: 1),
  );

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

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
      floatingActionButton: Stack(
        alignment: Alignment.center,
        children: [
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            emissionFrequency: 0.01,
            numberOfParticles: 80,
          ),
          BlocListener<TodosCubit, TodosState>(
            listener: (context, state) {
              if (state is TodoAddedSuccess) {
                _confettiController.play();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(milliseconds: 800),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    content: AwesomeSnackbarContent(
                      title: 'Added!',
                      message: 'Your task was added successfully.',
                      contentType: ContentType.success,
                    ),
                  ),
                );
              } else if (state is TodosError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return AddTodoDialog(
                      selectedDate: DateTime.now(),
                      onSaved: (todo) {
                        context.read<TodosCubit>().addTodo(todo);
                        context.pop();
                        context.read<ProjectsCubit>().isInProjectDetailsPage
                            ? context.read<ProjectsCubit>().loadProjectsTodos(
                                todo.project ?? ProjectEntity.defaultProject(),
                              )
                            : context.read<ProjectsCubit>().init();
                      },
                    );
                  },
                );
              },
              backgroundColor: DarkMoodAppColors.kSelectedItemColor,
              child: const Icon(Icons.add, color: AppColors.kWhiteColor),
            ),
          ),
        ],
      ),
    );
  }
}

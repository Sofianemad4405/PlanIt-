import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planitt/core/entities/project_entity.dart';
import 'package:planitt/core/theme/app_colors.dart';
import 'package:planitt/core/utils/constants.dart';
import 'package:planitt/core/widgets/add_todo_dialog.dart';
import 'package:planitt/core/widgets/custom_nav_bar.dart';
import 'package:planitt/core/widgets/shared_widgets.dart';
import 'package:planitt/features/calender/presentation/views/calendar_page_view_body.dart';
import 'package:planitt/features/focus/presentation/views/focus_page_view_body.dart';
import 'package:planitt/features/home/presentation/cubit/todos_cubit.dart';
import 'package:planitt/features/home/presentation/views/home_page_view_body.dart';
import 'package:planitt/features/projects/presentation/cubit/projects_cubit.dart';
import 'package:planitt/features/projects/presentation/views/projects_page_view_body.dart';

class Root extends StatefulWidget {
  const Root({super.key});
  static const String routeName = kRootRoute;

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int _currentIndex = 0;
  late PageController _pageController;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
    _pageController = PageController();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_currentIndex == index) return;
    setState(() => _currentIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  void _showAddTodoSheet() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.6),
      builder: (context) => AddTodoDialog(
        selectedDate: DateTime.now(),
        onSaved: (todo) {
          context.read<TodosCubit>().addTodo(todo);
          Navigator.of(context).pop();
          final projectsCubit = context.read<ProjectsCubit>();
          if (projectsCubit.isInProjectDetailsPage) {
            projectsCubit.loadProjectsTodos(
              todo.project ?? ProjectEntity.defaultProject(),
            );
          } else {
            projectsCubit.init();
          }
        },
        selectedProject:
            context.read<ProjectsCubit>().isInProjectDetailsPage
                ? context.read<ProjectsCubit>().selectedProject
                : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      extendBody: true,
      body: GradientBackground(
        child: BlocListener<TodosCubit, TodosState>(
          listener: (context, state) {
            if (state is TodoAddedSuccess) {
              _confettiController.play();
              _showSuccessSnackbar(context, 'Task added successfully 🎯');
            } else if (state is TodosError) {
              _showErrorSnackbar(context, state.error);
            }
          },
          child: Stack(
            children: [
              PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: const [
                  HomePageViewBody(),
                  ProjectsPageViewBody(),
                  CalendarPageViewBody(),
                  FocusPageViewBody(),
                ],
              ),
              // Confetti overlay
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: false,
                  emissionFrequency: 0.05,
                  numberOfParticles: 60,
                  gravity: 0.1,
                  colors: const [
                    AppColors.kAccent,
                    AppColors.kAccentSecondary,
                    AppColors.kGreenColor,
                    AppColors.kOrangeColor,
                    Colors.white,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PlanItNavBar(
            currentIndex: _currentIndex,
            onItemTapped: _onItemTapped,
          ),
        ],
      ),
      floatingActionButton: PlanItFAB(onTap: _showAddTodoSheet),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  void _showSuccessSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: AppColors.kGreenColor, size: 20),
            const SizedBox(width: 10),
            Text(message, style: const TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
        backgroundColor: DarkMoodAppColors.kSurfaceElevated,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        duration: const Duration(milliseconds: 1800),
        elevation: 0,
      ),
    );
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_rounded, color: AppColors.kRedColor, size: 20),
            const SizedBox(width: 10),
            Expanded(child: Text(message, style: const TextStyle(fontWeight: FontWeight.w500))),
          ],
        ),
        backgroundColor: DarkMoodAppColors.kSurfaceElevated,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        duration: const Duration(seconds: 3),
        elevation: 0,
      ),
    );
  }
}

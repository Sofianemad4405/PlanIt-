import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:planitt/app/controllers/language_controller.dart';
import 'package:planitt/core/entities/to_do_entity.dart';
import 'package:planitt/core/services/prefs.dart';
import 'package:planitt/core/theme/app_colors.dart';
import 'package:planitt/core/theme/app_numbers.dart';
import 'package:planitt/core/utils/constants.dart';
import 'package:planitt/core/widgets/task_search_field.dart';
import 'package:planitt/features/home/presentation/cubit/todos_cubit.dart';
import 'package:planitt/features/home/presentation/widgets/no_tasks.dart';
import 'package:planitt/features/home/presentation/widgets/todo_read_dialog.dart';
import 'package:planitt/features/home/presentation/widgets/todos_list_view.dart';
import 'package:planitt/features/projects/presentation/cubit/projects_cubit.dart';

class HomePageViewBody extends StatefulWidget {
  const HomePageViewBody({super.key});

  @override
  State<HomePageViewBody> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageViewBody>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  TextEditingController query = TextEditingController();
  late Timer _timer;
  String userArabicName = "";
  String userEnglishName = "";

  @override
  void initState() {
    super.initState();
    getUserArabicName();
    getUserEnglishName();
    _tabController = TabController(
      length: 3,
      vsync: this,
      animationDuration: const Duration(milliseconds: 20),
    );
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // _offsetAnimation =
    //     Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(
    //       CurvedAnimation(
    //         parent: _controller,
    //         curve: Curves.fastEaseInToSlowEaseOut,
    //       ),
    //     );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
    context.read<TodosCubit>().init();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  Future<void> getUserArabicName() async {
    userArabicName = await PreferencesService.getString(userArabicNameKey);
  }

  Future<void> getUserEnglishName() async {
    userEnglishName = await PreferencesService.getString(userEnglishNameKey);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controller.dispose();
    query.dispose();
    _timer.cancel();
    super.dispose();
  }

  bool showFilter = false;
  OverlayEntry? _overlayEntry;
  Set<String> selectedPriorities = {};
  Set<String> selectedProjects = {};

  void _toggleOverlay() {
    if (_overlayEntry == null) {
      _showOverlay();
    } else {
      _removeOverlay();
    }
  }

  void _showOverlay() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _removeOverlay,
              child: Container(color: Colors.transparent),
            ),
          ),
          Positioned(
            left: position.dx,
            top: position.dy,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 300,
                height: 400,
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Filter Todos".tr(),
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
                      const Gap(10),
                      Text(
                        "Priorities".tr(),
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                      ),
                      const Gap(10),
                      ...priorities.map((p) {
                        return StatefulBuilder(
                          builder: (context, setStateOverlay) {
                            return CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              splashRadius: 0,
                              overlayColor: const WidgetStatePropertyAll(
                                Colors.transparent,
                              ),
                              hoverColor: Colors.transparent,
                              tileColor: Colors.transparent,
                              dense: true,
                              checkColor: Theme.of(
                                context,
                              ).colorScheme.onSurface,
                              value: selectedPriorities.contains(p),
                              title: Text(p),
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (checked) {
                                setState(() {
                                  if (checked == true) {
                                    selectedPriorities.add(p);
                                  } else {
                                    selectedPriorities.remove(p);
                                  }
                                });
                                context.read<TodosCubit>().filterTodos(
                                  projects: selectedProjects.toList(),
                                  priorities: selectedPriorities.toList(),
                                );
                                setStateOverlay(() {});
                              },
                            );
                          },
                        );
                      }),
                      const Gap(10),
                      Text(
                        "Projects".tr(),
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                      ),
                      const Gap(10),
                      ...context.read<ProjectsCubit>().projects.map((p) {
                        return StatefulBuilder(
                          builder: (context, setStateOverlay) {
                            return CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              splashRadius: 0,
                              overlayColor: const WidgetStatePropertyAll(
                                Colors.transparent,
                              ),
                              hoverColor: Colors.transparent,
                              tileColor: Colors.transparent,
                              dense: true,
                              checkColor: Theme.of(
                                context,
                              ).colorScheme.onSurface,
                              value: selectedProjects.contains(p.name),
                              title: Text(p.name),
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (checked) {
                                setState(() {
                                  if (checked == true) {
                                    selectedProjects.add(p.name);
                                  } else {
                                    selectedProjects.remove(p.name);
                                  }
                                });
                                context.read<TodosCubit>().filterTodos(
                                  projects: selectedProjects.toList(),
                                  priorities: selectedPriorities.toList(),
                                );
                                setStateOverlay(() {});
                              },
                            );
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LanguageController.getLocale(context).languageCode == "ar"
                        ? "${getGreeting()}، $userArabicName"
                        : "${getGreeting()}, $userEnglishName",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    DateFormat(
                      'EEEE، d MMMM',
                      context.locale.toString(),
                    ).format(DateTime.now()),
                    style: const TextStyle(
                      color: DarkMoodAppColors.kUnSelectedItemColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  const Gap(10),
                  BlocBuilder<TodosCubit, TodosState>(
                    builder: (context, state) {
                      if (state is TodosLoaded) {
                        final todos = state.todos.where((todo) {
                          return todo.isOverdue && !todo.isFinished;
                        }).toList();
                        return todos.isNotEmpty
                            ? Text(
                                "${todos.length} ${"overdue tasks".tr()}",
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : const SizedBox();
                      }
                      return const SizedBox();
                    },
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: CustomTextField(
                            controller: query,
                            onChanged: (value) {
                              if (value.isEmpty) {
                                context.read<TodosCubit>().getAllTodos();
                              } else {
                                context.read<TodosCubit>().searchTodos(value);
                              }
                            },
                            hint: "Search".tr(),
                            prefixIcon: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: _toggleOverlay,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color:
                                selectedPriorities.isNotEmpty ||
                                    selectedProjects.isNotEmpty
                                ? AppColors.kAddTodoColor
                                : Theme.of(
                                    context,
                                  ).inputDecorationTheme.fillColor,
                            borderRadius: BorderRadius.circular(
                              AppNumbers.kEight,
                            ),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/svgs/filter.svg",
                              height: 25,
                              width: 25,
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).colorScheme.onSurface,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverAppBar(
            pinned: true,
            floating: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            automaticallyImplyLeading: false,
            toolbarHeight: 0,
            bottom: TabBar(
              dividerColor: Colors.grey[700],
              controller: _tabController,
              tabs: [
                Tab(text: "Today".tr()),
                Tab(text: "Upcoming".tr()),
                Tab(text: "All".tr()),
              ],
              labelColor: DarkMoodAppColors.kSelectedItemColor,
              unselectedLabelColor: DarkMoodAppColors.kUnSelectedItemColor,
              indicatorColor: DarkMoodAppColors.kSelectedItemColor,
              indicatorWeight: 2,
            ),
          ),
        ];
      },
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocConsumer<TodosCubit, TodosState>(
          listener: (context, state) {},
          builder: (context, state) {
            final List<ToDoEntity> todayTodos = (state is TodosLoaded)
                ? state.todos.where((todo) => todo.isToday).toList()
                : [];
            final List<ToDoEntity> upcomingTodos = state is TodosLoaded
                ? state.todos.where((todo) => !todo.isToday).toList()
                : [];
            final List<ToDoEntity> allTodos = state is TodosLoaded
                ? state.todos
                : [];
            todayTodos.sort((a, b) {
              final aIndex = priorities.indexOf(a.priority);
              final bIndex = priorities.indexOf(b.priority);
              return bIndex.compareTo(aIndex);
            });
            upcomingTodos.sort((a, b) {
              final aIndex = priorities.indexOf(a.priority);
              final bIndex = priorities.indexOf(b.priority);
              return bIndex.compareTo(aIndex);
            });
            allTodos.sort((a, b) {
              final aIndex = priorities.indexOf(a.priority);
              final bIndex = priorities.indexOf(b.priority);
              return bIndex.compareTo(aIndex);
            });
            return TabBarView(
              // physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                todayTodos.isEmpty
                    ? const NoTasks(text: "No tasks for today")
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: TodosListView(
                            todos: todayTodos,
                            onDelete: (todo) {
                              context.read<TodosCubit>().deleteTodo(todo);
                            },
                            onTileTab: (todo) {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    TodoReadDialog(toDoKey: todo.key),
                              );
                            },
                          ),
                        ),
                      ),
                upcomingTodos.isEmpty
                    ? const NoTasks(text: "No upcoming tasks")
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: TodosListView(
                          todos: upcomingTodos,
                          onDelete: (todo) {
                            context.read<TodosCubit>().deleteTodo(todo);
                          },
                          onTileTab: (todo) {
                            // context.read<HomeCubit>().viewTodo(todo);
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  TodoReadDialog(toDoKey: todo.key),
                            );
                          },
                        ),
                      ),
                allTodos.isEmpty
                    ? const NoTasks(text: "No tasks added yet")
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: TodosListView(
                          todos: allTodos,
                          onDelete: (todo) {
                            context.read<TodosCubit>().deleteTodo(todo);
                          },
                          onTileTab: (todo) {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  TodoReadDialog(toDoKey: todo.key),
                            );
                          },
                        ),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}

String getGreeting() {
  final hour = DateTime.now().hour;
  if (hour < 12) {
    return "Good Morning".tr();
  } else if (hour < 18) {
    return "Good Afternoon".tr();
  } else {
    return "Good Evening".tr();
  }
}

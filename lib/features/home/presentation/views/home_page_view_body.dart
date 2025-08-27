import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:planitt/core/entities/to_do_entity.dart';
import 'package:planitt/core/theme/app_colors.dart';
import 'package:planitt/core/theme/app_numbers.dart';
import 'package:planitt/core/widgets/task_search_field.dart';
import 'package:planitt/features/home/presentation/cubit/todos_cubit.dart';
import 'package:planitt/features/home/presentation/widgets/no_tasks.dart';
import 'package:planitt/features/home/presentation/widgets/todo_read_dialog.dart';
import 'package:planitt/features/home/presentation/widgets/todos_list_view.dart';

class HomePageViewBody extends StatefulWidget {
  const HomePageViewBody({super.key});

  @override
  State<HomePageViewBody> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageViewBody>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
                    "Good Evening",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    DateFormat('EEEE, MMMM d').format(DateTime.now()),
                    style: const TextStyle(
                      color: DarkMoodAppColors.kUnSelectedItemColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Expanded(
                        child: SizedBox(
                          height: 50,
                          child: CustomTextField(
                            hint: "Search",
                            prefixIcon: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A1F),
                          borderRadius: BorderRadius.circular(
                            AppNumbers.kEight,
                          ),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            "assets/svgs/filter.svg",
                            height: 25,
                            width: 25,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
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
            floating: false,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            automaticallyImplyLeading: false,
            toolbarHeight: 0,
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: "Today"),
                Tab(text: "Upcoming"),
                Tab(text: "All"),
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
            final List<ToDoEntity> todayTodos = state is TodosSuccessHome
                ? state.todos.where((todo) => todo.isToday).toList()
                : [];
            final List<ToDoEntity> upcomingTodos = state is TodosSuccessHome
                ? state.todos.where((todo) => !todo.isToday).toList()
                : [];
            final List<ToDoEntity> allTodos = state is TodosSuccessHome
                ? state.todos
                : [];
            return TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                todayTodos.isEmpty
                    ? const NoTasks(text: "No tasks for today")
                    : TodosListView(
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
                upcomingTodos.isEmpty
                    ? const NoTasks(text: "No upcoming tasks")
                    : TodosListView(
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
                allTodos.isEmpty
                    ? const NoTasks(text: "No tasks added yet")
                    : TodosListView(
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
              ],
            );
          },
        ),
      ),
    );
  }
}

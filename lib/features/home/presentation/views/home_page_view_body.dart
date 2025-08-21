import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:planitt/core/providers/providers.dart';
import 'package:planitt/core/theme/app_colors.dart';
import 'package:planitt/core/theme/app_numbers.dart';
import 'package:planitt/core/widgets/task_search_field.dart';
import 'package:planitt/features/home/presentation/widgets/todos_list_view.dart';

class HomePageViewBody extends ConsumerStatefulWidget {
  const HomePageViewBody({super.key});

  @override
  ConsumerState<HomePageViewBody> createState() => _HomePageViewState();
}

class _HomePageViewState extends ConsumerState<HomePageViewBody>
    with TickerProviderStateMixin {
  late TabController _tabController;

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
    final todos = ref.watch(todosControllerProvider);

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
                    "Wednesday, August 13",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: DarkMoodAppColors.kDateColor,
                      fontWeight: FontWeight.normal,
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
        child: TabBarView(
          controller: _tabController,
          children: [
            todos.when(
              data: (list) {
                final todayTodos = list.where((todo) => todo.isToday).toList();
                return TodosListView(todos: todayTodos);
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text(e.toString())),
            ),
            todos.when(
              data: (list) {
                final upcomingTodos = list
                    .where((todo) => !todo.isToday && !todo.isTomorrow)
                    .toList();
                return TodosListView(todos: upcomingTodos);
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text(e.toString())),
            ),
            todos.when(
              data: (list) => TodosListView(todos: list),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text(e.toString())),
            ),
          ],
        ),
      ),
    );
  }
}

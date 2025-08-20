import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:planitt/core/theme/app_colors.dart';
import 'package:planitt/core/theme/app_numbers.dart';
import 'package:planitt/core/widgets/task_search_field.dart';
import 'package:planitt/features/home/presentation/widgets/task_list_tile.dart';

class HomePageViewBody extends StatefulWidget {
  const HomePageViewBody({super.key});

  @override
  State<HomePageViewBody> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageViewBody>
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(10),
                Text(
                  "Good Evening",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(10),
                Text(
                  "Wednesday, August 13",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: DarkMoodAppColors.kDateColor,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
                Gap(20),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: CustomTextField(
                          hint: "Search",
                          prefixIcon: true,
                        ),
                      ),
                    ),
                    Gap(10),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1F),
                        borderRadius: BorderRadius.circular(AppNumbers.kEight),
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
                TabBar(
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
                  indicatorPadding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.zero,
                ),
                Gap(20),
              ],
            ),
          ),

          /// TabBarView بياخد المساحة المتبقية
          SliverFillRemaining(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    TaskListtile(),
                    Gap(AppNumbers.kEight),
                    TaskListtile(),
                    Gap(AppNumbers.kEight),
                    TaskListtile(),
                    Gap(AppNumbers.kEight),
                    TaskListtile(),
                    Gap(AppNumbers.kEight),
                  ],
                ),
                ListView(
                  children: const [
                    ListTile(title: Text("Task 1")),
                    ListTile(title: Text("Task 2")),
                    ListTile(title: Text("Task 3")),
                  ],
                ),
                ListView(
                  children: const [
                    ListTile(title: Text("Task 1")),
                    ListTile(title: Text("Task 2")),
                    ListTile(title: Text("Task 3")),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

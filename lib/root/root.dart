import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:planitt/core/theme/app_colors.dart';
import 'package:planitt/core/widgets/custom_app_bar.dart';
import 'package:planitt/core/widgets/custom_nav_bar.dart';
import 'package:planitt/core/widgets/task_search_field.dart';
import 'package:planitt/features/calender/presentation/views/calendar_page_view_body.dart';
import 'package:planitt/features/focus/presentation/views/focus_page_view_body.dart';
import 'package:planitt/features/home/presentation/views/home_page_view_body.dart';
import 'package:planitt/features/home/presentation/widgets/custom_dialog_row.dart';
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
      appBar: CustomAppBar(),
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
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff111216),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(20),
                  width: 361.59,
                  height: 406.88,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Add Task",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Icon(Iconsax.close_square),
                        ],
                      ),
                      Gap(10),
                      SizedBox(
                        height: 50,
                        child: CustomTextField(
                          hint: "Task Name",
                          prefixIcon: false,
                        ),
                      ),
                      Gap(10),
                      CustomTextField(
                        hint: "Description (Optional)",
                        prefixIcon: false,
                        isDesc: true,
                      ),
                      Gap(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: CustomDialogRow(
                              onTap: () {},
                              mainIcon: Iconsax.calendar,
                              text: "mm/dd/yyyy",
                              smallIcon: Iconsax.calendar,
                            ),
                          ),
                          Gap(10),
                          Expanded(
                            flex: 2,
                            child: CustomDialogRow(
                              onTap: () {},
                              mainIcon: Iconsax.calendar,
                              text: "Medium",
                              smallIcon: Iconsax.arrow_down_14,
                            ),
                          ),
                        ],
                      ),
                      Gap(10),
                      CustomDialogRow(
                        onTap: () {},
                        mainIcon: Iconsax.flag,
                        text: "Inbox",
                        smallIcon: Iconsax.arrow_down_14,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        backgroundColor: DarkMoodAppColors.kSelectedItemColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}

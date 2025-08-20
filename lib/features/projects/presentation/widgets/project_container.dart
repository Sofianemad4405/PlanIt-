import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:planitt/core/theme/app_colors.dart';
import 'package:planitt/core/theme/app_numbers.dart';

class ProjectContainer extends StatelessWidget {
  const ProjectContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: 87.97,
      width: width * 0.5,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: DarkMoodAppColors.kRedColor, width: 4),
        ),
        borderRadius: BorderRadius.circular(AppNumbers.kEight),
        color: DarkMoodAppColors.kFillColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset("assets/svgs/project1.svg"),
                Gap(20),
                Text("Inbox", style: TextStyle(color: Colors.white)),
                Spacer(),
                PopupMenuButton<String>(
                  icon: const Icon(
                    Icons.more_horiz,
                    color: DarkMoodAppColors.kWhiteColor,
                  ), // 3 dots
                  onSelected: (value) {
                    if (value == 'delete') {
                      // هنا تحط اللوجيك بتاع الحذف
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(const SnackBar(content: Text("Deleted")));
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      height: 20,
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 8),
                          Text("Delete"),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text("0 Tasks", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

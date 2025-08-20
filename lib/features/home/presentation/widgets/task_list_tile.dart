import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:planitt/core/entities/to_do_entity.dart';
import 'package:planitt/core/theme/app_colors.dart';
import 'package:planitt/core/theme/app_images.dart';
import 'package:planitt/core/theme/app_numbers.dart';

class TaskListtile extends StatelessWidget {
  const TaskListtile({super.key, required this.toDo});
  final ToDoEntity toDo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: AppNumbers.kListTileHeight,
      tileColor: DarkMoodAppColors.kFillColor,
      title: Text(
        toDo.title,
        style: TextStyle(
          color: DarkMoodAppColors.kRedColor,
          fontSize: AppNumbers.kSixteen,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Row(
        children: [
          Container(
            height: AppNumbers.kNineteen,
            decoration: ShapeDecoration(
              color: const Color(0x1FF59E0B),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  toDo.project,
                  style: TextStyle(
                    color: Color(0xffF59E0B),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          Gap(5),
          Row(
            children: [
              SvgPicture.asset(
                height: 15,
                width: 15,
                AppImages.kCalendarIcon,
                colorFilter: ColorFilter.mode(
                  DarkMoodAppColors.kRedColor,
                  BlendMode.srcIn,
                ),
              ),
              Gap(5),
              toDo.isToday
                  ? Text(
                      toDo.dueDate.toString(),
                      style: TextStyle(color: DarkMoodAppColors.kRedColor),
                    )
                  : toDo.isTomorrow
                  ? Text(
                      toDo.dueDate.toString(),
                      style: TextStyle(color: DarkMoodAppColors.kRedColor),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ],
      ),
      leading: SvgPicture.asset(AppImages.listTileLeading),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      trailing: Container(
        height: AppNumbers.kTwelve,
        width: AppNumbers.kTwelve,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: DarkMoodAppColors.kRedColor,
        ),
      ),
    );
  }
}

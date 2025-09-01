import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:planitt/core/converters/date_convertors.dart';
import 'package:planitt/core/entities/to_do_entity.dart';
import 'package:planitt/core/theme/app_colors.dart';
import 'package:planitt/core/theme/app_images.dart';
import 'package:planitt/core/theme/app_numbers.dart';

class TaskListtile extends StatelessWidget {
  const TaskListtile({
    super.key,
    required this.toDo,
    required this.onDelete,
    required this.onTileTab,
  });
  final ToDoEntity toDo;
  final VoidCallback onDelete;
  final VoidCallback onTileTab;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTileTab(),
      minTileHeight: AppNumbers.kListTileHeight,
      tileColor: Theme.of(context).listTileTheme.tileColor,
      title: Text(
        toDo.title,
        style: TextStyle(
          color: toDo.isToday
              ? AppColors.kRedColor
              : Theme.of(context).colorScheme.onSurface,
          fontSize: AppNumbers.kSixteen,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Row(
        children: [
          Container(
            height: AppNumbers.kNineteen,
            decoration: ShapeDecoration(
              color: toDo.project.name == "Work"
                  ? const Color(0xffF59E0B).withValues(alpha: 0.125)
                  : toDo.project.name == "Personal"
                  ? const Color(0xff10B981).withValues(alpha: 0.125)
                  : toDo.project.name == "Inbox"
                  ? const Color(0xff4F46E5).withValues(alpha: 0.125)
                  : toDo.project.color.color.withValues(alpha: 0.125),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  toDo.project.name,
                  style: TextStyle(
                    color: toDo.project.name == "Inbox"
                        ? AppColors.kProjectIconColor1
                        : toDo.project.name == "Personal"
                        ? AppColors.kProjectIconColor2
                        : toDo.project.name == "Work"
                        ? AppColors.kProjectIconColor3
                        : toDo.project.color.color,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          const Gap(5),
          Row(
            children: [
              SvgPicture.asset(
                height: 15,
                width: 15,
                AppImages.kCalendarIcon,
                colorFilter: ColorFilter.mode(
                  toDo.isToday
                      ? AppColors.kRedColor
                      : Theme.of(context).colorScheme.onSurface,
                  BlendMode.srcIn,
                ),
              ),
              const Gap(5),
              toDo.isToday
                  ? Text(
                      "Today".tr(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    )
                  : toDo.isTomorrow
                  ? Text(
                      "Tomorrow".tr(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    )
                  : Text(
                      "${dateToMonth(toDo.dueDate!.month)} ${toDo.dueDate!.day}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ],
          ),
        ],
      ),
      leading: GestureDetector(
        onTap: () => onDelete(),
        child: SvgPicture.asset(AppImages.listTileLeading),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      trailing: Container(
        height: AppNumbers.kTwelve,
        width: AppNumbers.kTwelve,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: toDo.priority == "Low"
              ? AppColors.kLowPriorityColor
              : toDo.priority == "Medium"
              ? AppColors.kMediumPriorityColor
              : toDo.priority == "High"
              ? AppColors.kHighPriorityColor
              : toDo.priority == "Urgent"
              ? AppColors.kUrgentPriorityColor
              : AppColors.kProjectIconColor9,
        ),
      ),
    );
  }
}

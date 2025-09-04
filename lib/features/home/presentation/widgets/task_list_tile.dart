import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
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
    required this.onTaskCompleted,
  });
  final ToDoEntity toDo;
  final VoidCallback onDelete;
  final VoidCallback onTileTab;
  final VoidCallback onTaskCompleted;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Dismissible(
      key: ValueKey(toDo.key),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Iconsax.trash, color: Colors.white),
      ),
      onDismissed: (direction) {
        onDelete();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(milliseconds: 800),
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: AwesomeSnackbarContent(
              title: 'Deleted!',
              message: 'Your task was removed successfully.',
              contentType: ContentType.success,
            ),
          ),
        );
      },
      child: ListTile(
        onTap: () => onTileTab(),
        minTileHeight: AppNumbers.kListTileHeight,
        tileColor: Theme.of(context).listTileTheme.tileColor,
        title: Text(
          toDo.title,
          style: TextStyle(
            decoration: toDo.isFinished ? TextDecoration.lineThrough : null,
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
                color:
                    toDo.project?.color.color.withValues(alpha: 0.125) ??
                    AppColors.kProjectIconColor1.withValues(alpha: 0.125),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: width * 0.2,
                      minWidth: 0,
                    ),
                    child: Text(
                      toDo.project?.name ?? "No Project",
                      style: TextStyle(
                        decoration: toDo.isFinished
                            ? TextDecoration.lineThrough
                            : null,
                        color:
                            toDo.project?.color.color ??
                            AppColors.kProjectIconColor1,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
                          decoration: toDo.isFinished
                              ? TextDecoration.lineThrough
                              : null,
                          color: Theme.of(context).colorScheme.error,
                        ),
                      )
                    : toDo.isTomorrow
                    ? Text(
                        "Tomorrow".tr(),
                        style: TextStyle(
                          decoration: toDo.isFinished
                              ? TextDecoration.lineThrough
                              : null,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      )
                    : Text(
                        "${dateToMonth(toDo.dueDate!.month)} ${toDo.dueDate!.day}",
                        style: TextStyle(
                          decoration: toDo.isFinished
                              ? TextDecoration.lineThrough
                              : null,
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
          onTap: () {
            onTaskCompleted();
          },
          child: toDo.isFinished
              ? const Icon(Iconsax.tick_circle5, color: Colors.green)
              : SvgPicture.asset(AppImages.listTileLeading),
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
      ),
    );
  }
}

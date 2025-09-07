import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planitt/core/entities/to_do_entity.dart';
import 'package:planitt/features/focus/presentation/widgets/controller_button.dart';
import 'package:planitt/features/home/presentation/widgets/todo_read_dialog.dart';

class FocusTodoTile extends StatelessWidget {
  const FocusTodoTile({
    super.key,
    required this.todo,
    required this.onActivatingFocus,
    required this.onDeactivatingFocus,
    required this.isFocusing,
  });
  final ToDoEntity todo;
  final VoidCallback onActivatingFocus;
  final VoidCallback onDeactivatingFocus;
  final bool isFocusing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      minTileHeight: 80,
      title: Text(
        todo.title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        "${"Due".tr()} : ${DateFormat("yyyy/MM/dd", context.locale.toString()).format(todo.dueDate ?? DateTime.now())}",
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: GestureDetector(
        onTap: () {
          onActivatingFocus();
        },
        child: isFocusing
            ? ControllerButton(
                icon: Icon(
                  Icons.check,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                onPressed: () {
                  onDeactivatingFocus();
                },
                isPauseAndRunning: true,
              )
            : SvgPicture.asset(
                "assets/svgs/continue.svg",
                colorFilter: const ColorFilter.mode(
                  Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return TodoReadDialog(toDoKey: todo.key);
          },
        );
      },
    );
  }
}

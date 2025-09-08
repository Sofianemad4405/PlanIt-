import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planitt/core/entities/to_do_entity.dart';
import 'package:planitt/core/theme/app_colors.dart';
import 'package:planitt/core/utils/extention.dart';
import 'package:planitt/core/widgets/add_todo_dialog.dart';
import 'package:planitt/features/home/presentation/cubit/todos_cubit.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

/// The hove page which hosts the calendar
class CalendarPageViewBody extends StatefulWidget {
  /// Creates the home page to display teh calendar widget.
  const CalendarPageViewBody({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalendarPageViewBodyState createState() => _CalendarPageViewBodyState();
}

class _CalendarPageViewBodyState extends State<CalendarPageViewBody>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _offsetAnimation =
        Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.fastEaseInToSlowEaseOut,
          ),
        );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: BlocConsumer<TodosCubit, TodosState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SfCalendar(
            onTap: (details) {
              if (details.targetElement == CalendarElement.calendarCell &&
                  details.date != null) {
                final selectedDate = details.date!;
                showDialog(
                  context: context,
                  builder: (context) {
                    return AddTodoDialog(
                      selectedDate: selectedDate,
                      onSaved: (todo) {
                        context.read<TodosCubit>().addTodo(todo);
                        context.pop();
                      },
                    );
                  },
                );
              }
            },
            view: CalendarView.month,
            dataSource: TodosDataSource(_getDataSource()),
            monthViewSettings: const MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            ),
          );
        },
      ),
    );
  }

  List<ToDoEntity> _getDataSource() {
    final List<ToDoEntity> todos = context.read<TodosCubit>().todos;
    return todos;
  }
}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class TodosDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  TodosDataSource(List<ToDoEntity> todos) {
    appointments = todos;
  }

  @override
  DateTime getStartTime(int index) {
    return _getTodoData(index).createdAt;
  }

  @override
  DateTime getEndTime(int index) {
    return _getTodoData(index).dueDate ??
        DateTime.now().add(const Duration(days: 1));
  }

  @override
  String getSubject(int index) {
    return _getTodoData(index).title;
  }

  @override
  Color getColor(int index) {
    return Color(
      _getTodoData(index).project?.color.value ??
          AppColors.kProjectIconColor1.toARGB32(),
    );
  }

  @override
  bool isAllDay(int index) {
    return true;
  }

  ToDoEntity _getTodoData(int index) {
    final dynamic todo = appointments![index];
    late final ToDoEntity todoData;
    if (todo is ToDoEntity) {
      todoData = todo;
    }

    return todoData;
  }
}

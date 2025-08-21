import 'package:planitt/core/entities/project_entity.dart';

class ToDoEntity {
  final int key;
  final String title;
  final String? description;
  final DateTime createdAt;
  final DateTime? dueDate;
  final String priority;
  final List<String>? subtasks;
  final ProjectEntity project;
  final bool isToday;
  final bool isTomorrow;
  final bool isOverdue;

  ToDoEntity({
    required this.title,
    this.description,
    required this.createdAt,
    this.dueDate,
    this.priority = "Medium",
    this.subtasks,
    required this.project,
    this.isToday = false,
    this.isTomorrow = false,
    this.isOverdue = false,
    required this.key,
  });
}

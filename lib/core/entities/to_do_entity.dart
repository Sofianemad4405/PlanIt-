import 'package:planitt/core/entities/project_entity.dart';
import 'package:planitt/core/entities/subtask_entity.dart';

class ToDoEntity {
  final String key;
  final String title;
  final String? description;
  final DateTime createdAt;
  final DateTime? dueDate;
  final String priority;
  final List<SubtaskEntity>? subtasks;
  final ProjectEntity project;
  final bool isToday;
  final bool isTomorrow;
  final bool isOverdue;
  final bool isFinished;

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
    this.isFinished = false,
  });
}

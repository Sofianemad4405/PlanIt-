class ToDoModel {
  final String title;
  final String? description;
  final DateTime createdAt;
  final DateTime? dueDate;
  final String priority;
  final List<String>? subtasks;
  final String project;
  final bool isToday;
  final bool isTomorrow;
  final bool isOverdue;

  ToDoModel({
    required this.title,
    required this.description,
    required this.createdAt,
    required this.dueDate,
    this.priority = "Medium",
    required this.subtasks,
    this.project = "Inbox",
    required this.isToday,
    required this.isTomorrow,
    required this.isOverdue,
  });
}

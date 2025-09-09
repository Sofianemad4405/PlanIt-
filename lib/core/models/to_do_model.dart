import 'package:hive/hive.dart';
import 'package:planitt/core/entities/to_do_entity.dart';
import 'package:planitt/core/models/subtask_model.dart';
import 'package:planitt/features/projects/data/models/project_model.dart';

part 'to_do_model.g.dart';

@HiveType(typeId: 0)
class ToDoModel extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String? description;
  @HiveField(2)
  final DateTime createdAt;
  @HiveField(3)
  final DateTime? dueDate;
  @HiveField(4)
  final String priority;
  @HiveField(5)
  final List<SubtaskModel>? subtasks;
  @HiveField(6)
  final ProjectModel? project;
  @HiveField(7)
  final bool isToday;
  @HiveField(8)
  final bool isTomorrow;
  @HiveField(9)
  final bool isOverdue;
  @override
  @HiveField(10)
  final String key;
  @HiveField(11)
  final bool isFinished;

  ToDoModel({
    required this.title,
    this.description,
    required this.createdAt,
    this.dueDate,
    this.priority = "Medium",
    this.subtasks,
    this.project,
    this.isToday = false,
    this.isTomorrow = false,
    this.isOverdue = false,
    required this.key,
    this.isFinished = false,
  });

  factory ToDoModel.fromEntity(ToDoEntity entity) {
    return ToDoModel(
      title: entity.title,
      description: entity.description,
      createdAt: entity.createdAt,
      dueDate: entity.dueDate,
      priority: entity.priority,
      subtasks: entity.subtasks
          ?.map((e) => SubtaskModel.fromEntity(e))
          .toList(),
      project: entity.project == null
          ? null
          : ProjectModel.fromEntity(entity.project),
      isToday: entity.isToday,
      isTomorrow: entity.isTomorrow,
      isOverdue: entity.isOverdue,
      key: entity.key,
      isFinished: entity.isFinished,
    );
  }

  ToDoEntity toEntity() {
    return ToDoEntity(
      title: title,
      description: description,
      createdAt: createdAt,
      dueDate: dueDate,
      priority: priority,
      subtasks: subtasks?.map((e) => e.toEntity()).toList(),
      project: project?.toEntity(),
      isToday: isToday,
      isTomorrow: isTomorrow,
      isOverdue: isOverdue,
      key: key,
    );
  }
}

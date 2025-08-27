import 'package:hive/hive.dart';
import 'package:planitt/core/entities/subtask_entity.dart';

part 'subtask_model.g.dart';

@HiveType(typeId: 4)
class SubtaskModel extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final bool isCompleted;
  @HiveField(2)
  final int index;

  SubtaskModel({
    required this.title,
    this.isCompleted = false,
    required this.index,
  });

  factory SubtaskModel.fromEntity(SubtaskEntity entity) {
    return SubtaskModel(
      title: entity.title,
      isCompleted: entity.isCompleted,
      index: entity.index,
    );
  }
  SubtaskEntity toEntity() {
    return SubtaskEntity(title: title, isCompleted: isCompleted, index: index);
  }
}

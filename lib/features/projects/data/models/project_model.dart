import 'dart:ui';

import 'package:hive/hive.dart';
import 'package:planitt/core/entities/project_entity.dart';

part 'project_model.g.dart';

@HiveType(typeId: 1)
class ProjectModel extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final Color color;
  @HiveField(2)
  final String? icon;

  ProjectModel({required this.name, required this.color, this.icon});

  ProjectEntity toEntity() {
    return ProjectEntity(name: name, color: color, icon: icon);
  }

  factory ProjectModel.fromEntity(ProjectEntity entity) {
    return ProjectModel(
      name: entity.name,
      color: entity.color,
      icon: entity.icon,
    );
  }
}

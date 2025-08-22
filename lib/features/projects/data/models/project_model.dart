import 'package:hive/hive.dart';
import 'package:planitt/core/adapters/color_model.dart';
import 'package:planitt/core/entities/project_entity.dart';

part 'project_model.g.dart';

@HiveType(typeId: 1)
class ProjectModel extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final ColorModel color;
  @HiveField(2)
  final String? icon;
  @HiveField(3)
  final String id;

  ProjectModel({
    required this.name,
    required this.color,
    this.icon,
    required this.id,
  });

  ProjectEntity toEntity() {
    return ProjectEntity(name: name, color: color, icon: icon, id: id);
  }

  factory ProjectModel.fromEntity(ProjectEntity entity) {
    return ProjectModel(
      name: entity.name,
      color: entity.color,
      icon: entity.icon,
      id: entity.id,
    );
  }
}

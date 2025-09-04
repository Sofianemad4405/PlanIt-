import 'package:planitt/core/adapters/color_model.dart';
import 'package:planitt/core/entities/to_do_entity.dart';
import 'package:planitt/core/theme/app_colors.dart';
import 'package:planitt/core/utils/constants.dart';

class ProjectEntity {
  final String id;
  final String name;
  final ColorModel color;
  final String? icon;
  final List<ToDoEntity> todos;

  ProjectEntity({
    required this.id,
    required this.name,
    required this.color,
    this.icon,
    required this.todos,
  });
  ProjectEntity copyWith({
    String? id,
    String? name,
    ColorModel? color,
    String? icon,
    List<ToDoEntity>? todos,
  }) {
    return ProjectEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      todos: todos ?? this.todos,
    );
  }

  static ProjectEntity defaultProject() {
    return ProjectEntity(
      id: "0",
      name: "No Project",
      color: ColorModel(AppColors.kProjectIconColor1.toARGB32()),
      todos: [],
      icon: projectsIcons[0],
    );
  }
}

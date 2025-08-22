import 'package:planitt/core/adapters/color_model.dart';

class ProjectEntity {
  final String id;
  final String name;
  final ColorModel color;
  final String? icon;

  ProjectEntity({
    required this.id,
    required this.name,
    required this.color,
    this.icon,
  });
}

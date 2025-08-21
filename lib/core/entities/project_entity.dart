import 'dart:ui';

class ProjectEntity {
  final String id;
  final String name;
  final Color color;
  final String? icon;

  ProjectEntity({
    required this.id,
    required this.name,
    required this.color,
    this.icon,
  });
}

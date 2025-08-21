import 'dart:ui';

class ProjectEntity {
  final int? id;
  final String name;
  final Color color;
  final String? icon;

  ProjectEntity({this.id, required this.name, required this.color, this.icon});
}

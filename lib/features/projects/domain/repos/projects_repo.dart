import 'package:planitt/core/entities/project_entity.dart';

abstract class ProjectsRepo {
  Future<List<ProjectEntity>> getProjects();
  Future<void> addProject(ProjectEntity project);
  Future<void> deleteProject(ProjectEntity project);
}

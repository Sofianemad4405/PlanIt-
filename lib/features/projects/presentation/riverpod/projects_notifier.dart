import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planitt/core/entities/project_entity.dart';
import 'package:planitt/features/projects/data/data_sources/projects_data_source.dart';

class ProjectsNotifier extends StateNotifier<AsyncValue<List<ProjectEntity>>> {
  final ProjectsDataSource dataSource;
  ProjectsNotifier(this.dataSource) : super(const AsyncValue.loading()) {
    getAllProjects();
  }

  /// Get All Projects
  Future<void> getAllProjects() async {
    try {
      final projects = await dataSource.getProjects();
      state = AsyncValue.data(projects);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Add Project
  Future<void> addProject(ProjectEntity project) async {
    try {
      await dataSource.addProject(project);
      getAllProjects();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Delete Project
  Future<void> deleteProject(ProjectEntity project) async {
    try {
      await dataSource.deleteProject(project);
      getAllProjects();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

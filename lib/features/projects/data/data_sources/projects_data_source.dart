import 'package:planitt/core/entities/project_entity.dart';
import 'package:planitt/core/services/abstract_storage_service.dart';
import 'package:planitt/core/utils/constants.dart';

abstract class ProjectsDataSource {
  Future<List<ProjectEntity>> getProjects();
  Future<void> addProject(ProjectEntity project);
  Future<void> deleteProject(ProjectEntity project);
}

class ProjectsDataSourceImpl implements ProjectsDataSource {
  final AbstractStorageService storageService;
  ProjectsDataSourceImpl(this.storageService);

  @override
  Future<List<ProjectEntity>> getProjects() async {
    final projects = await storageService.getAll<ProjectEntity>(
      boxName: projectsBoxName,
    );
    return projects;
  }

  @override
  Future<void> addProject(ProjectEntity project) async {
    await storageService.addItem(boxName: projectsBoxName, value: project);
  }

  @override
  Future<void> deleteProject(ProjectEntity project) async {
    await storageService.delete(boxName: projectsBoxName, key: project.id);
  }
}

import 'package:planitt/core/services/abstract_storage_service.dart';
import 'package:planitt/core/utils/constants.dart';
import 'package:planitt/features/projects/data/models/project_model.dart';

abstract class ProjectsDataSource {
  Future<List<ProjectModel>> getProjects();
  Future<void> addProject(ProjectModel project);
  Future<void> deleteProject(ProjectModel project);
}

class ProjectsDataSourceImpl implements ProjectsDataSource {
  final AbstractStorageService storageService;
  ProjectsDataSourceImpl(this.storageService);

  @override
  Future<List<ProjectModel>> getProjects() async {
    final projects = await storageService.getAll<ProjectModel>(
      boxName: projectsBoxName,
    );
    return projects;
  }

  @override
  Future<void> addProject(ProjectModel project) async {
    await storageService.addItem(boxName: projectsBoxName, value: project);
  }

  @override
  Future<void> deleteProject(ProjectModel project) async {
    await storageService.delete(boxName: projectsBoxName, key: project.id);
  }
}

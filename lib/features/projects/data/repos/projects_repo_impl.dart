import 'package:planitt/core/entities/project_entity.dart';
import 'package:planitt/features/projects/data/data_sources/projects_data_source.dart';
import 'package:planitt/features/projects/data/models/project_model.dart';
import 'package:planitt/features/projects/domain/repos/projects_repo.dart';

class ProjectsRepoImpl implements ProjectsRepo {
  final ProjectsDataSource dataSource;
  ProjectsRepoImpl(this.dataSource);

  @override
  Future<List<ProjectEntity>> getProjects() async {
    final projects = await dataSource.getProjects();
    return projects.map((project) => project.toEntity()).toList();
  }

  @override
  Future<void> addProject(ProjectEntity project) async {
    await dataSource.addProject(ProjectModel.fromEntity(project));
  }

  @override
  Future<void> deleteProject(ProjectEntity project) async {
    await dataSource.deleteProject(ProjectModel.fromEntity(project));
  }
}

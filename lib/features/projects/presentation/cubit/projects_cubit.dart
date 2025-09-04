import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:planitt/core/entities/project_entity.dart';
import 'package:planitt/core/entities/to_do_entity.dart';
import 'package:planitt/core/utils/constants.dart';
import 'package:planitt/features/home/domain/repos/home_todos_repo.dart';
import 'package:planitt/features/home/presentation/cubit/todos_cubit.dart';
import 'package:planitt/features/projects/data/models/project_model.dart';
import 'package:planitt/features/projects/domain/repos/projects_repo.dart';

part 'projects_state.dart';

class ProjectsCubit extends Cubit<ProjectsState> {
  ProjectsCubit(this.projectsRepo, this.todosRepo, this.todosCubit)
    : super(ProjectsInitial());

  final ProjectsRepo projectsRepo;
  final HomeTodosRepo todosRepo;
  final TodosCubit todosCubit;

  List<ProjectEntity> projects = [];
  ProjectEntity? selectedProject;
  bool isInProjectDetailsPage = false;

  Future<void> init() async {
    await getAllProjects();
    if (projects.isNotEmpty) {
      final todos = await todosRepo.getAllTodos();
      projects = projects.map((p) {
        return p.copyWith(
          todos: todos.where((todo) => todo.project?.id == p.id).toList(),
        );
      }).toList();
      emit(ProjectsLoaded(projects: projects));
    }
  }

  Future<void> getAllProjects() async {
    try {
      emit(ProjectsLoading());
      final projectBox = await Hive.openBox<ProjectModel>(projectsBoxName);
      final fetchedProjects = projectBox.values.map((p) {
        return ProjectEntity(
          name: p.name,
          color: p.color,
          id: p.id,
          todos: p.toEntity().todos,
          icon: p.icon,
        );
      }).toList();

      projects = fetchedProjects;
      emit(ProjectsLoaded(projects: projects));
    } catch (e) {
      emit(ProjectsError(error: e.toString()));
    }
  }

  Future<void> loadProjectsTodos(ProjectEntity project) async {
    try {
      final todos = await todosRepo.getAllTodos();
      projects = projects.map((p) {
        return p.copyWith(
          todos: todos.where((todo) => todo.project?.id == p.id).toList(),
        );
      }).toList();

      final updatedProject = projects.firstWhere(
        (p) => p.id == project.id,
        orElse: () => project,
      );
      emit(ProjectDetailsLoaded(project: updatedProject));
    } catch (e) {
      emit(ProjectsError(error: e.toString()));
    }
  }

  Future<void> addProject(ProjectEntity project) async {
    try {
      await projectsRepo.addProject(project);
      projects = [...projects, project];
      emit(ProjectsLoaded(projects: projects));
    } catch (e) {
      emit(ProjectsError(error: e.toString()));
    }
  }

  Future<void> deleteProject(ProjectEntity project) async {
    try {
      await projectsRepo.deleteProject(project);
      projects.removeWhere((p) => p.id == project.id);
      await todosCubit.deleteProjectTodos(project.id);
      emit(ProjectsLoaded(projects: projects));
    } catch (e) {
      emit(ProjectsError(error: e.toString()));
    }
  }

  void toggleProjectsPageState(
    bool isInProjectDetailsPage,
    ProjectEntity project,
  ) {
    if (isInProjectDetailsPage) {
      emit(ProjectDetailsLoaded(project: project));
    } else {
      emit(ProjectsLoaded(projects: projects));
    }
  }
}

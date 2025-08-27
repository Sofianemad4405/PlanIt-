import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:planitt/core/adapters/color_model.dart';
import 'package:planitt/core/entities/project_entity.dart';
import 'package:planitt/core/theme/app_colors.dart';
import 'package:planitt/core/utils/constants.dart';
import 'package:planitt/features/home/domain/repos/home_todos_repo.dart';
import 'package:planitt/features/projects/data/models/project_model.dart';
import 'package:planitt/features/projects/domain/repos/projects_repo.dart';

part 'projects_state.dart';

class ProjectsCubit extends Cubit<ProjectsState> {
  ProjectsCubit(this.projectsRepo, this.todosRepo) : super(ProjectsInitial());

  final ProjectsRepo projectsRepo;
  final HomeTodosRepo todosRepo;
  List<ProjectEntity> projects = [];

  Future<void> seedDefaultProjects() async {
    final projectBox = await Hive.openBox<ProjectModel>(projectsBoxName);
    if (projectBox.isEmpty) {
      await projectBox.addAll([
        ProjectModel(
          name: "Inbox",
          color: ColorModel(DarkMoodAppColors.kProjectIconColor1.value),
          id: "0",
          todos: [],
          icon: projectsIcons[0],
        ),
        ProjectModel(
          name: "Personal",
          color: ColorModel(DarkMoodAppColors.kProjectIconColor2.value),
          id: "1",
          todos: [],
          icon: projectsIcons[1],
        ),
        ProjectModel(
          name: "Work",
          color: ColorModel(DarkMoodAppColors.kProjectIconColor3.value),
          id: "2",
          todos: [],
          icon: projectsIcons[2],
        ),
      ]);
    }
  }

  void viewProjectDetails(ProjectEntity project) {
    emit(ProjectsDetailsViewing(project: project));
  }

  Future<void> loadProjectsTodos() async {
    try {
      final todos = await todosRepo.getAllTodos();
      projects = projects.map((project) {
        return project.copyWith(
          todos: todos.where((todo) => todo.project.id == project.id).toList(),
        );
      }).toList();
      emit(ProjectsLoaded(projects: projects));
    } catch (e) {
      emit(ProjectsError(error: e.toString()));
    }
  }

  void init() {
    seedDefaultProjects();
    getAllProjects();
  }

  Future<void> getAllProjects() async {
    try {
      projects = await projectsRepo.getProjects();
      loadProjectsTodos();
      emit(ProjectsLoaded(projects: projects));
    } catch (e) {
      emit(ProjectsError(error: e.toString()));
    }
  }

  Future<void> deleteProject(ProjectEntity project) async {
    try {
      await projectsRepo.deleteProject(project);
      projects.remove(project);
      emit(ProjectsLoaded(projects: projects));
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
}

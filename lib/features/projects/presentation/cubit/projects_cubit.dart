import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:planitt/core/adapters/color_model.dart';
import 'package:planitt/core/entities/project_entity.dart';
import 'package:planitt/core/entities/to_do_entity.dart';
import 'package:planitt/core/models/to_do_model.dart';
import 'package:planitt/core/theme/app_colors.dart';
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
    await seedDefaultProjects();
    await getAllProjects();
    await loadProjectsTodos(selectedProject ?? ProjectEntity.defaultProject());
    if (projects.isNotEmpty) {
      selectedProject = projects[0];
    } else {
      selectedProject = ProjectEntity.defaultProject();
    }
  }

  Future<void> seedDefaultProjects() async {
    final projectBox = await Hive.openBox<ProjectModel>(projectsBoxName);
    if (projectBox.isEmpty) {
      await projectBox.addAll([
        ProjectModel(
          name: "Inbox",
          color: ColorModel(AppColors.kProjectIconColor1.value),
          id: "0",
          todos: [],
          icon: projectsIcons[0],
        ),
        ProjectModel(
          name: "Personal",
          color: ColorModel(AppColors.kProjectIconColor2.value),
          id: "1",
          todos: [],
          icon: projectsIcons[1],
        ),
        ProjectModel(
          name: "Work",
          color: ColorModel(AppColors.kProjectIconColor3.value),
          id: "2",
          todos: [],
          icon: projectsIcons[2],
        ),
      ]);
    }
  }

  void viewProjectDetails(ProjectEntity project) {
    emit(TodosLoadedInProjectDetailsPage(project: project));
  }

  Future<void> loadProjectsTodos(ProjectEntity project) async {
    try {
      final todos = await todosRepo.getAllTodos();
      projects = projects.map((project) {
        return project.copyWith(
          todos: todos.where((todo) => todo.project.id == project.id).toList(),
        );
      }).toList();
      if (isInProjectDetailsPage) {
        emit(TodosLoadedInProjectDetailsPage(project: project));
      } else {
        emit(ProjectsLoadedInMainProjectsPage(projects: projects));
      }
    } catch (e) {
      emit(ProjectsError(error: e.toString()));
    }
  }

  void toggleProjectsPageState(
    bool isInProjectDetailsPage,
    ProjectEntity project,
  ) {
    if (!isInProjectDetailsPage) {
      emit(TodosLoadedInProjectDetailsPage(project: project));
    } else {
      emit(ProjectsLoadedInMainProjectsPage(projects: projects));
    }
  }

  Future<void> getAllProjects() async {
    final projectBox = await Hive.openBox<ProjectModel>(projectsBoxName);

    final fetchedProjects = projectBox.values
        .map(
          (p) => ProjectEntity(
            name: p.name,
            color: p.color,
            id: p.id,
            todos: p.toEntity().todos,
            icon: p.icon,
          ),
        )
        .toList();

    projects = fetchedProjects;

    if (projects.isNotEmpty) {
      selectedProject = ProjectEntity.defaultProject();
    }

    // emit(ProjectsLoadedInMainProjectsPage(projects: projects));
  }

  Future<void> deleteProject(ProjectEntity project) async {
    try {
      await projectsRepo.deleteProject(project);
      projects.remove(project);
      emit(ProjectsLoadedInMainProjectsPage(projects: projects));
    } catch (e) {
      emit(ProjectsError(error: e.toString()));
    }
  }

  Future<void> addProject(ProjectEntity project) async {
    try {
      await projectsRepo.addProject(project);
      projects = [...projects, project];
      emit(ProjectsLoadedInMainProjectsPage(projects: projects));
    } catch (e) {
      emit(ProjectsError(error: e.toString()));
    }
  }

  void setIsInProjectDetailsPage(bool value) {
    isInProjectDetailsPage = value;
    emit(ProjectsLoadedInMainProjectsPage(projects: projects));
  }

  Future<void> deleteTodoFromProject(
    ToDoEntity todo,
    ProjectEntity project,
  ) async {
    try {
      await todosCubit.deleteTodoFromProject(todo, project);
      emit(TodosLoadedInProjectDetailsPage(project: project));
    } catch (e) {
      emit(ProjectsError(error: e.toString()));
    }
  }
}

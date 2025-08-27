part of 'projects_cubit.dart';

@immutable
sealed class ProjectsState {}

final class ProjectsInitial extends ProjectsState {}

final class ProjectsLoading extends ProjectsState {}

final class ProjectsLoaded extends ProjectsState {
  final List<ProjectEntity> projects;
  ProjectsLoaded({required this.projects});
}

final class ProjectsDetailsViewing extends ProjectsState {
  final ProjectEntity project;
  ProjectsDetailsViewing({required this.project});
}

final class ProjectsError extends ProjectsState {
  final String error;
  ProjectsError({required this.error});
}

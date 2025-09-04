part of 'projects_cubit.dart';

@immutable
sealed class ProjectsState {}

final class ProjectsInitial extends ProjectsState {}

final class ProjectsLoading extends ProjectsState {}

final class ProjectsLoaded extends ProjectsState {
  final List<ProjectEntity> projects;
  ProjectsLoaded({required this.projects});
}

final class ProjectsError extends ProjectsState {
  final String error;
  ProjectsError({required this.error});
}

/// تفاصيل مشروع معين (ممكن يحتوي todos كمان)
final class ProjectDetailsLoaded extends ProjectsState {
  final ProjectEntity project;
  ProjectDetailsLoaded({required this.project});
}

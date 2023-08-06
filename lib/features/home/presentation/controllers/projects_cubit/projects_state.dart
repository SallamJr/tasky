part of 'projects_cubit.dart';

class ProjectsState extends Equatable {
  const ProjectsState({
    required this.projects,
    required this.message,
    required this.status,
  });

  final List<Project> projects;
  final String message;
  final ControllerStateStatus status;

  factory ProjectsState.initial() => const ProjectsState(
        projects: [],
        message: '',
        status: ControllerStateStatus.initial,
      );

  @override
  List<Object> get props => [
        projects,
        message,
        status,
      ];

  ProjectsState copyWith({
    List<Project>? projects,
    String? message,
    ControllerStateStatus? status,
  }) {
    return ProjectsState(
      projects: projects ?? this.projects,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }
}

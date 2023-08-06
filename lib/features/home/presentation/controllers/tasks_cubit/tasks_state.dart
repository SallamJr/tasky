part of 'tasks_cubit.dart';

class TasksState extends Equatable {
  const TasksState({
    required this.status,
    required this.message,
    required this.selectedProject,
    required this.tasks,
  });

  final ControllerStateStatus status;
  final String message;
  final Project? selectedProject;
  final List<MyTask> tasks;

  factory TasksState.initial() {
    return const TasksState(
      status: ControllerStateStatus.initial,
      message: '',
      selectedProject: null,
      tasks: [],
    );
  }

  TasksState copyWith({
    ControllerStateStatus? status,
    String? message,
    Project? selectedProject,
    List<MyTask>? tasks,
  }) {
    return TasksState(
      status: status ?? this.status,
      message: message ?? this.message,
      selectedProject: selectedProject ?? this.selectedProject,
      tasks: tasks ?? this.tasks,
    );
  }

  @override
  List<Object?> get props => [
        status,
        message,
        selectedProject,
        tasks,
      ];
}

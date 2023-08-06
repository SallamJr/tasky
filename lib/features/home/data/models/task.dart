import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class MyTask extends Equatable {
  const MyTask({
    required this.id,
    required this.projectId,
    required this.title,
    required this.isCompleted,
    required this.createdAt,
  });

  final String id;
  final String projectId;
  final String title;
  final bool isCompleted;
  final DateTime createdAt;

  MyTask copyWith({
    String? id,
    String? projectId,
    String? title,
    bool? isCompleted,
    DateTime? createdAt,
  }) {
    return MyTask(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory MyTask.fromJson(Map<String, dynamic> json) => _$MyTaskFromJson(json);

  Map<String, dynamic> toJson() => _$MyTaskToJson(this);

  @override
  List<Object> get props => [
        id,
        projectId,
        title,
        isCompleted,
        createdAt,
      ];
}

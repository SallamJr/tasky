import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

@JsonSerializable()
class Project extends Equatable {
  const Project({
    required this.id,
    required this.title,
    required this.isCompleted,
    required this.createdAt,
    this.owner,
    this.collaborators,
  });

  final String id;
  final String title;
  final bool isCompleted;
  final DateTime createdAt;
  final String? owner;
  final List<String>? collaborators;

  Project copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    DateTime? createdAt,
    String? owner,
    List<String>? collaborators,
  }) {
    return Project(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      owner: owner ?? this.owner,
      collaborators: collaborators ?? this.collaborators,
    );
  }

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        isCompleted,
        createdAt,
        owner,
        collaborators,
      ];
}

part of 'auth_repo_cubit.dart';

class AuthRepoState extends Equatable {
  const AuthRepoState({
    required this.message,
    required this.user,
    required this.status,
  });

  final String message;
  final UserModel? user;
  final ControllerStateStatus status;

  factory AuthRepoState.initial() => const AuthRepoState(
        message: '',
        user: null,
        status: ControllerStateStatus.initial,
      );

  AuthRepoState copyWith({
    String? message,
    UserModel? user,
    ControllerStateStatus? status,
  }) {
    return AuthRepoState(
      message: message ?? this.message,
      user: user ?? this.user,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        message,
        user,
        status,
      ];
}

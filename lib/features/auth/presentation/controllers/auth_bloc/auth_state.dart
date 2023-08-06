part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final String status;

  const AuthState({
    required this.status,
  });

  @override
  List<Object> get props => [status];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'status': status});

    return result;
  }

  factory AuthState.fromMap(Map<String, dynamic> map) {
    return AuthState(
      status: map['status'] ?? '',
    );
  }
}

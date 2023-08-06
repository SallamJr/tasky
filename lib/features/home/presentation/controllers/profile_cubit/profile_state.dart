// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState({
    required this.status,
    required this.user,
    required this.message,
  });

  final ControllerStateStatus status;
  final UserModel user;
  final String message;

  factory ProfileState.initial() {
    return ProfileState(
      status: ControllerStateStatus.initial,
      user: UserModel.empty(),
      message: '',
    );
  }

  ProfileState copyWith({
    ControllerStateStatus? status,
    UserModel? user,
    String? message,
  }) {
    return ProfileState(
      status: status ?? this.status,
      user: user ?? this.user,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        status,
        user,
        message,
      ];
}

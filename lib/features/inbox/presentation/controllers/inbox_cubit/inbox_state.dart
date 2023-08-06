part of 'inbox_cubit.dart';

class InboxState extends Equatable {
  const InboxState({
    required this.user,
    required this.status,
    required this.scrollPosition,
    required this.message,
  });

  final UserModel user;
  final ControllerStateStatus status;
  final MyScrollPosition scrollPosition;
  final String message;

  factory InboxState.initial() {
    return InboxState(
      user: UserModel.empty(),
      status: ControllerStateStatus.initial,
      scrollPosition: MyScrollPosition.initial,
      message: '',
    );
  }

  InboxState copyWith({
    UserModel? user,
    ControllerStateStatus? status,
    MyScrollPosition? scrollPosition,
    String? message,
  }) {
    return InboxState(
      user: user ?? this.user,
      status: status ?? this.status,
      scrollPosition: scrollPosition ?? this.scrollPosition,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        user,
        status,
        scrollPosition,
        message,
      ];
}

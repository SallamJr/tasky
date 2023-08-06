part of 'nav_bar_cubit.dart';

class NavBarState extends Equatable {
  const NavBarState({
    required this.index,
  });

  final int index;

  factory NavBarState.initial() => const NavBarState(
        index: 0,
      );

  NavBarState copyWith({
    int? index,
  }) =>
      NavBarState(
        index: index ?? this.index,
      );

  @override
  List<Object> get props => [
        index,
      ];
}

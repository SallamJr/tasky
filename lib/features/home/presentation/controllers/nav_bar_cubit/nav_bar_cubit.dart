import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit()
      : super(
          NavBarState.initial(),
        );

  final PageController pageController = PageController();

  void changeSelectedIndex({
    required int index,
  }) {
    pageController.jumpToPage(
      index,
    );
    emit(
      state.copyWith(
        index: index,
      ),
    );
  }

  void resetCubit() {
    pageController.initialPage;
    emit(
      NavBarState.initial(),
    );
  }
}

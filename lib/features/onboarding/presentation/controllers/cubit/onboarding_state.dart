part of 'onboarding_cubit.dart';

sealed class OnboardingState extends Equatable {
  const OnboardingState({
    required this.status,
  });

  final bool status;

  @override
  List<Object> get props => [
        status,
      ];
}

class ChangeOnboardingState extends OnboardingState {
  const ChangeOnboardingState({
    required super.status,
  });
}

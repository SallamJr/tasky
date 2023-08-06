import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../../../../core/utils/app_strings.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState(status: AppStrings.authStateInitial)) {
    on<SignOutRequestedEvent>(_onSignOutRequestedEvent);
    on<GuestRequestedEvent>(_onGuestRequestedEvent);
    on<AuthenticatedRequestedEvent>(_onAuthenticatedRequestedEvent);
  }

  void _onSignOutRequestedEvent(
    SignOutRequestedEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(const AuthState(status: AppStrings.authStateLogout));
  }

  void _onGuestRequestedEvent(
    GuestRequestedEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(const AuthState(status: AppStrings.authStateGuest));
  }

  void _onAuthenticatedRequestedEvent(
    AuthenticatedRequestedEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(const AuthState(status: AppStrings.authStateAuthenticated));
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    return AuthState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.toMap();
  }
}

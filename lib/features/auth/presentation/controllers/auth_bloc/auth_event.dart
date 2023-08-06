part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignOutRequestedEvent extends AuthEvent {}

class GuestRequestedEvent extends AuthEvent {}

class AuthenticatedRequestedEvent extends AuthEvent {}

part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {
  final User user;

  const LoggedIn(this.user);

  @override
  List<Object?> get props => [user];
}

class LoggedOut extends AuthEvent {}

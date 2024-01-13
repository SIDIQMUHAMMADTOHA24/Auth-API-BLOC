part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {
  final String token;

  const LoggedIn({required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() {
    // TODO: implement toString
    return 'LoggedIn(token : $token)';
  }
}

class LoggedOut extends AuthEvent {}

class Register extends AuthEvent {
  final String token;

  const Register({required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() {
    // TODO: implement toString
    return 'LoggedIn(token : $token)';
  }
}

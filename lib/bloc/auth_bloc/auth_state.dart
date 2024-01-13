part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthAuthenticated extends AuthState {
  final String email;

  const AuthAuthenticated({required this.email});

  @override
  List<Object> get props => [email];
}

final class AuthUnauthenticated extends AuthState {}

import 'dart:math';

import 'package:auth_bloc/repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;
  AuthBloc({required this.userRepository}) : super(AuthInitial()) {
    on<AppStarted>((event, emit) async {
      final bool hasToken = await userRepository.hasToken();
      final String email = await userRepository.getEmail();
      if (hasToken) {
        emit(AuthAuthenticated(email: email));
      } else {
        emit(AuthUnauthenticated());
      }
    });

    on<LoggedIn>((event, emit) async {
      emit(AuthLoading());
      await userRepository.persisToken(event.token);
      final String email = await userRepository.getEmail();
      emit(AuthAuthenticated(email: email));
    });

    on<Register>((event, emit) async {
      emit(AuthLoading());
      await userRepository.persisToken(event.token);
      final String email = await userRepository.getEmail();
      emit(AuthAuthenticated(email: email));
    });

    on<LoggedOut>((event, emit) async {
      emit(AuthLoading());
      await userRepository.deleteToken();
      emit(AuthUnauthenticated());
    });
  }
}

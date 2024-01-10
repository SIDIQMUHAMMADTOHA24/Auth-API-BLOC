import 'package:auth_bloc/bloc/auth_bloc/auth_bloc.dart';
import 'package:auth_bloc/obs.dart';
import 'package:auth_bloc/repository/user_repository.dart';
import 'package:auth_bloc/screen/auth/login_screen.dart';
import 'package:auth_bloc/screen/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = SimpleObserver();
  final userRepository = UserRepository();
  runApp(BlocProvider(
    create: (context) {
      return AuthBloc(userRepository: userRepository)..add(AppStarted());
    },
    child: MyApp(
      userRepository: userRepository,
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.userRepository});
  final UserRepository userRepository;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        locale: const Locale('id', 'ID'),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              return const MainScreen();
            }
            if (state is AuthUnauthenticated) {
              return LoginScreen(userRepository: userRepository);
            }
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ));
  }
}

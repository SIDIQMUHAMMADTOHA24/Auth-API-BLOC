import 'package:auth_bloc/bloc/auth_bloc/auth_bloc.dart';
import 'package:auth_bloc/bloc/login_bloc/login_bloc.dart';
import 'package:auth_bloc/bloc/register_bloc/register_bloc.dart';
import 'package:auth_bloc/obs.dart';
import 'package:auth_bloc/repository/user_repository.dart';
import 'package:auth_bloc/screen/auth/register_screen.dart';
import 'package:auth_bloc/screen/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = SimpleObserver();
  final userRepository = UserRepository();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) =>
          AuthBloc(userRepository: userRepository)..add(AppStarted()),
    ),
    BlocProvider(
        create: (context) => LoginBloc(
            userRepository: userRepository,
            authBloc: BlocProvider.of<AuthBloc>(context))),
    BlocProvider(
      create: (context) => RegisterBloc(
          userRepository: userRepository,
          authBloc: BlocProvider.of<AuthBloc>(context)),
    )
  ], child: MyApp(userRepository: userRepository)));
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
              return RegisterScreen(
                // userRepository: userRepository,
              );
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

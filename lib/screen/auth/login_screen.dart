import 'package:auth_bloc/bloc/auth_bloc/auth_bloc.dart';
import 'package:auth_bloc/bloc/login_bloc/login_bloc.dart';
import 'package:auth_bloc/repository/user_repository.dart';
import 'package:auth_bloc/screen/auth/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository userRepository;
  const LoginScreen({super.key, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
              userRepository: userRepository,
              authBloc: BlocProvider.of<AuthBloc>(context));
        },
        child: LoginForm(userRepository: userRepository),
      ),
    );
  }
}

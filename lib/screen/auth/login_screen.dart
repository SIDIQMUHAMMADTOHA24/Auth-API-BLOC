import 'package:auth_bloc/bloc/login_bloc/login_bloc.dart';
import 'package:auth_bloc/repository/user_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository userRepository;
  LoginScreen({super.key, required this.userRepository});

  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is LoginFailure) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text(state.error),
            ),
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _userNameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4))),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4))),
                ),
                const SizedBox(
                  height: 20,
                ),
                (state is LoginLoading)
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          if (_passwordController.text.length < 8) {
                            showDialog(
                              context: context,
                              builder: (context) => const AlertDialog(
                                content: Text('Password min 8 charakter'),
                              ),
                            );
                          } else {
                            BlocProvider.of<LoginBloc>(context).add(
                                LoginButtonPressed(
                                    email: _userNameController.text,
                                    password: _passwordController.text));
                          }
                        },
                        child: const Text('Log in'))
              ],
            ),
          ),
        );
      },
    ));
  }
}

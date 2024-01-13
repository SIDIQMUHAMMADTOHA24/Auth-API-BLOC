import 'package:auth_bloc/bloc/register_bloc/register_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state is RegisterLoading) {
                const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is RegisterFailure) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text(state.error),
                  ),
                );
              }
            },
            builder: (context, state) {
              return Column(
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
                  (state is RegisterLoading)
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            context.read<RegisterBloc>().add(
                                RegisterButtonPressed(
                                    email: _userNameController.text,
                                    password: _passwordController.text));
                          },
                          child: const Text('Register'))
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

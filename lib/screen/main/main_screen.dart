import 'package:auth_bloc/bloc/auth_bloc/auth_bloc.dart';
import 'package:auth_bloc/bloc/login_bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Auth With Rest'),
        leading: IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(LoggedOut());
            },
            icon: const Icon(Icons.logout_outlined)),
      ),
      // body: BlocBuilder<RegisterBloc, RegisterState>(
      //   builder: (context, state) {
      //     if (state is RegisterSuccess) {
      //       return Center(
      //         child: Text(state.userModel.email),
      //       );
      //     }
      //     if (state is RegisterLoading) {
      //       return const Center(
      //         child: Text('Loading'),
      //       );
      //     }
      //     return const Center(child: Text('Kosong'));
      //   },
      // ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            return Center(
              child: Text(state.email),
            );
          }
          if (state is AuthLoading) {
            return const Center(
              child: Text('Loading'),
            );
          }
          return const Center(child: Text('Kosong'));
        },
      ),
    );
  }
}

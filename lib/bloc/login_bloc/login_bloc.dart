import 'package:auth_bloc/bloc/auth_bloc/auth_bloc.dart';
import 'package:auth_bloc/model/user_model.dart';
import 'package:auth_bloc/repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthBloc authBloc;
  LoginBloc({required this.userRepository, required this.authBloc})
      : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        final token = await userRepository.login(event.email, event.password);
        authBloc.add(LoggedIn(token: token));
        emit(LoginSuccess(
            userModel:
                UserModel(email: event.email, password: event.password)));
      } catch (error) {
        //handle error
        if (error is DioException) {
          var errorMessage = error.response?.data['error'];
          emit(LoginFailure(error: errorMessage));
        } else {
          emit(LoginFailure(error: error.toString()));
        }
      }
    });
  }
}


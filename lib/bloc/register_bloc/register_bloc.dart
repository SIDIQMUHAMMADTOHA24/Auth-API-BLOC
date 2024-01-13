import 'package:auth_bloc/bloc/auth_bloc/auth_bloc.dart';
import 'package:auth_bloc/model/user_model.dart';
import 'package:auth_bloc/repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;
  final AuthBloc authBloc;
  RegisterBloc({required this.userRepository, required this.authBloc})
      : super(RegisterInitial()) {
    on<RegisterButtonPressed>((event, emit) async {
      emit(RegisterLoading());
      try {
        final token =
            await userRepository.register(event.email, event.password);
        authBloc.add(Register(token: token));
        emit(RegisterSuccess(
            userModel:
                UserModel(email: event.email, password: event.password)));
      } catch (error) {
        //handle error
        if (error is DioException) {
          var errorMessage = error.response?.data['error'];
          emit(RegisterFailure(error: errorMessage));
        } else {
          emit(RegisterFailure(error: error.toString()));
        }
      }
    });
  }
}

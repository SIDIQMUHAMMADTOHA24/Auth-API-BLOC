part of 'register_bloc.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  final UserModel userModel;

  const RegisterSuccess({required this.userModel});

  @override
  List<Object> get props => [UserModel];
}

final class RegisterFailure extends RegisterState {
  final String error;

  const RegisterFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    // TODO: implement toString
    return 'RegisterFailure(error : $error)';
  }
}

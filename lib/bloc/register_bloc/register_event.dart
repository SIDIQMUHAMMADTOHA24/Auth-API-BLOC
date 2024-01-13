part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterButtonPressed extends RegisterEvent {
  final String email;
  final String password;

  const RegisterButtonPressed({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    // TODO: implement toString
    return 'RegisterButtonPressed(email : $email, password : $password)';
  }
}

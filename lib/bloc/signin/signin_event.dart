part of 'signin_bloc.dart';

sealed class SigninEvent extends Equatable {
  const SigninEvent();
}

class SigninEmailChanged extends SigninEvent {
  final String email;
  const SigninEmailChanged({required this.email});

  @override
  List<Object?> get props => [email];
}

class SigninPasswordChanged extends SigninEvent {
  final String password;
  const SigninPasswordChanged({required this.password});

  @override
  List<Object?> get props => [password];
}

class SigninSubmitted extends SigninEvent {
  @override
  List<Object?> get props => [];
}


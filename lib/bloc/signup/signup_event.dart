part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();
}

class SignupUsernameChanged extends SignupEvent {
  final String username;
  const SignupUsernameChanged(this.username);

  @override
  List<Object?> get props => [username];
}

class SignupCompanyNameChanged extends SignupEvent {
  final String companyName;
  const SignupCompanyNameChanged(this.companyName);

  @override
  List<Object?> get props => [companyName];
}

class SignupEmailChanged extends SignupEvent {
  final String email;
  const SignupEmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class SignupPasswordChanged extends SignupEvent {
  final String password;
  const SignupPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class SignupSubmitted extends SignupEvent {

  @override
  List<Object?> get props => [];
}
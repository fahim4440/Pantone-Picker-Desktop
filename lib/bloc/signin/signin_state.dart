part of 'signin_bloc.dart';

class SigninState {
  final String email;
  final String password;
  final bool isValidEmail;
  final bool isValidPassword;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String errorMessage;

  SigninState({
    required this.email,
    required this.password,
    required this.isValidEmail,
    required this.isValidPassword,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
    required this.errorMessage,
  });

  factory SigninState.initial() {
    return SigninState(
      email: '',
      password: '',
      isValidEmail: false,
      isValidPassword: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      errorMessage: '',
    );
  }

  // The copyWith function allows us to create a copy of the current state
  // while updating only the specified fields.
  SigninState copyWith({
    String? email,
    String? password,
    bool? isValidEmail,
    bool? isValidPassword,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    String? errorMessage,
  }) {
    return SigninState(
      email: email ?? this.email,
      password: password ?? this.password,
      isValidEmail: isValidEmail ?? this.isValidEmail,
      isValidPassword: isValidPassword ?? this.isValidPassword,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

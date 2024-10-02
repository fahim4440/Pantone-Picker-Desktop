part of 'signup_bloc.dart';

// sealed class SignupState extends Equatable {
//   const SignupState();
// }

// final class SignupInitial extends SignupState {
//   @override
//   List<Object> get props => [];
// }

class SignupState {
  final String username;
  final String companyName;
  final String email;
  final String password;
  final bool isValidName;
  final bool isValidCompanyName;
  final bool isValidEmail;
  final bool isValidPassword;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String errorMessage;

  SignupState({
    required this.username,
    required this.companyName,
    required this.email,
    required this.password,
    required this.isValidName,
    required this.isValidCompanyName,
    required this.isValidEmail,
    required this.isValidPassword,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
    required this.errorMessage,
  });

  factory SignupState.initial() {
    return SignupState(
      username: '',
      companyName: '',
      email: '',
      password: '',
      isValidName: false,
      isValidCompanyName: false,
      isValidEmail: false,
      isValidPassword: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      errorMessage: '',
    );
  }

  SignupState copyWith({
    String? username,
    String? companyName,
    String? email,
    String? password,
    bool? isValidName,
    bool? isValidCompanyName,
    bool? isValidEmail,
    bool? isValidPassword,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    String? errorMessage,
  }) {
    return SignupState(
      username: username ?? this.username,
      companyName: companyName?? this.companyName,
      email: email ?? this.email,
      password: password ?? this.password,
      isValidName: isValidName ?? this.isValidName,
      isValidCompanyName: isValidCompanyName ?? this.isValidCompanyName,
      isValidEmail: isValidEmail ?? this.isValidEmail,
      isValidPassword: isValidPassword ?? this.isValidPassword,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

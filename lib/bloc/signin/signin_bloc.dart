import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pantone_book/model/user_model.dart';
import '../../repository/signin_repository.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc() : super(SigninState.initial()) {
    on<SigninEmailChanged>((event, emit) {
      emit(state.copyWith(
          email: event.email, isValidEmail: _isValidEmail(event.email)));
    });

    on<SigninPasswordChanged>((event, emit) {
      emit(state.copyWith(
          password: event.password,
          isValidPassword: _isValidPassword(event.password)));
    });

    on<SigninSubmitted>((event, emit) async {
      emit(state.copyWith(isSubmitting: true));
      try {
        if (state.isValidEmail && state.isValidPassword) {
          SigninRepository repository = SigninRepository();
          UserModel user = await repository.signInWithEmailAndPassword(state.email, state.password);
          if(user.isEmailVerified) {
            //here using email to flow the name in HomePage
            emit(state.copyWith(email: user.name, isSuccess: true, isSubmitting: false, isFailure: false, isEmailVerified: true));
            emit(SigninState.initial());
          } else {
            emit(state.copyWith(email: state.email, password: state.password, isEmailVerified: false, isSuccess: true, isSubmitting: false));
          }
        } else {
          throw ("Input email and password");
        }
      } catch (error) {
        String errorMessage;
        if (error.toString() == "[firebase_auth/invalid-credential] The supplied auth credential is incorrect, malformed or has expired.") {
          errorMessage = "Password is not correct";
        } else {
          errorMessage = error.toString();
        }
        emit(state.copyWith(isFailure: true, isSubmitting: false, errorMessage: errorMessage));
      }
    });

    on<SigninResendEmailVerificationEvent>((event, emit) async {
      SigninRepository repository = SigninRepository();
      await repository.resendEmail(state.email, state.password);
      emit(state.copyWith(isEmailVerified: false, isSuccess: false, isSubmitting: false));
    });
  }
}

bool _isValidEmail(String email) {
  return email.contains('@');
}

bool _isValidPassword(String password) {
  return password.length > 6;
}

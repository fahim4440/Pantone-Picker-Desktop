import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../repository/signup_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupState.initial()) {
    on<SignupUsernameChanged>((event, emit) {
      emit(state.copyWith(username: event.username, isValidName: _isValidName(event.username)));
    });

    on<SignupEmailChanged>((event, emit) {
      emit(state.copyWith(
          email: event.email, isValidEmail: _isValidEmail(event.email)));
    });

    on<SignupPasswordChanged>((event, emit) {
      emit(state.copyWith(
          password: event.password,
          isValidPassword: _isValidPassword(event.password)));
    });

    on<SignupSubmitted>((event, emit) async {
      emit(state.copyWith(isSubmitting: true, isFailure: false, isSuccess: false));
      try {
        if (state.isValidEmail && state.isValidPassword && state.isValidName) {
          SignupRepository repository = SignupRepository();
          await repository.signupWithEmailAndLink(
            state.username, state.email, state.password);
          emit(state.copyWith(isSuccess: true, isSubmitting: false));
          emit(SignupState.initial());
        } else {
          throw ("Input name or email or password");
        }
      } on FirebaseAuthException catch(error) {
        emit(state.copyWith(isFailure: true, isSubmitting: false, errorMessage: error.message.toString()));
      } catch (error) {
        emit(state.copyWith(isFailure: true, isSubmitting: false, errorMessage: error.toString()));
      }
    });
  }
}

bool _isValidEmail(String email) {
  return email.contains('@');
}

bool _isValidPassword(String password) {
  return password.length > 6;
}

bool _isValidName(String name) {
  return (name.contains(" ") && name.length > 5);
}

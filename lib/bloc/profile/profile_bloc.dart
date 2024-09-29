import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pantone_book/model/user_model.dart';
import '../../repository/profile_repository.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState.initial()) {
    on<ProfileLoggedOutEvent>((event, emit) async {
      try {
        emit(state.copyWith(isSubmitting: true));
        ProfileRepository repository = ProfileRepository();
        await repository.signout();
        emit(state.copyWith(isSuccess: true));
        emit(ProfileState.initial());
      } catch(error) {
        emit(state.copyWith(isFailure: true, isSubmitting: false, errorMessage: error.toString()));
      }
    });

    on<ProfilePageEnterEvent>((event, emit) async {
      try {
        ProfileRepository repository = ProfileRepository();
        UserModel user = await repository.getUserFromSharedPreferences();
        emit(ProfilePageEnterState(user, isSuccess: false, isFailure: true, isSubmitting: false, errorMessage: ''));
      } catch (error) {
        print(error.toString());
      }
    });
  }
}

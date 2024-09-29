import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repository/image_repository.dart';

part 'check_logged_in_event.dart';
part 'check_logged_in_state.dart';

class CheckLoggedInBloc extends Bloc<CheckLoggedInEvent, CheckLoggedInState> {
  CheckLoggedInBloc() : super(CheckLoggedInInitial()) {
    on<CheckLoggedInEvent>((event, emit) async {
      try {
        ImageRepository repository = ImageRepository();
        bool isLoggedIn = await repository.isUserLoggedIn();
        if (isLoggedIn) {
          emit(LoggedInState());
        } else {
          emit(LoggedOutState());
        }
      } catch(error) {
        print(error);
      }
    });
  }
}

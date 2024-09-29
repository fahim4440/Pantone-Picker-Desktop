part of 'check_logged_in_bloc.dart';

sealed class CheckLoggedInState extends Equatable {
  const CheckLoggedInState();
}

final class CheckLoggedInInitial extends CheckLoggedInState {
  @override
  List<Object> get props => [];
}

final class LoggedInState extends CheckLoggedInState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class LoggedOutState extends CheckLoggedInState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

part of 'check_logged_in_bloc.dart';

sealed class CheckLoggedInState extends Equatable {
  const CheckLoggedInState();
}

final class CheckLoggedInInitial extends CheckLoggedInState {
  @override
  List<Object> get props => [];
}

final class LoggedInState extends CheckLoggedInState {
  final String name;
  const LoggedInState(this.name);

  @override
  List<Object?> get props => [];
}

final class LoggedOutState extends CheckLoggedInState {
  @override
  List<Object?> get props => [];
}

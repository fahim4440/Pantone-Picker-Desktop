part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class ProfileLoggedOutEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}

class ProfilePageEnterEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}

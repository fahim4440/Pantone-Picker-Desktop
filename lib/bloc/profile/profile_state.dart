part of 'profile_bloc.dart';

// sealed class ProfileState extends Equatable {
//   const ProfileState();
// }
//
// final class ProfileInitial extends ProfileState {
//   @override
//   List<Object> get props => [];
// }

class ProfileState {
  final bool isSuccess;
  final bool isFailure;
  final bool isSubmitting;
  final String errorMessage;

  ProfileState({
    required this.isSuccess,
    required this.isFailure,
    required this.isSubmitting,
    required this.errorMessage,
  });

  factory ProfileState.initial() {
    return ProfileState(
      isSuccess: false,
      isFailure: true,
      isSubmitting: false,
      errorMessage: "",
    );
  }

  // The copyWith function allows us to create a copy of the current state
  // while updating only the specified fields.
  ProfileState copyWith({
    bool? isSuccess,
    bool? isFailure,
    bool? isSubmitting,
    String? errorMessage,
  }) {
    return ProfileState(
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}


class ProfilePageEnterState extends ProfileState {
  final UserModel user;

  ProfilePageEnterState(this.user, {required super.isSuccess, required super.isFailure, required super.isSubmitting, required super.errorMessage});

  List<Object?> get props => [user];
}
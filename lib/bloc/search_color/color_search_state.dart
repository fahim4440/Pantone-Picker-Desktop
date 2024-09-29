part of 'color_search_bloc.dart';

sealed class ColorSearchState extends Equatable {
  const ColorSearchState();
}

final class ColorSearchInitial extends ColorSearchState {
  @override
  List<Object> get props => [];
}

final class ColorSearchLoadingState extends ColorSearchState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


final class ColorSearchLoadedState extends ColorSearchState {
  final List<PantoneColor> colors;

  const ColorSearchLoadedState(this.colors);
  @override
  // TODO: implement props
  List<Object?> get props => [colors];
}

final class ColorSearchErrorState extends ColorSearchState {
  final String errorMessage;

  const ColorSearchErrorState(this.errorMessage);

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}
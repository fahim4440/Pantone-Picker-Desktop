part of 'color_picker_bloc.dart';

sealed class ColorPickerState extends Equatable {
  const ColorPickerState();
}

final class ColorPickerInitial extends ColorPickerState {
  @override
  List<Object> get props => [];
}

// final class ImageLoadedState extends ColorPickerState {
//   final File image;
//
//   const ImageLoadedState(this.image);
//
//   @override
//   // TODO: implement props
//   List<Object?> get props => [image];
// }

final class ColorPickedState extends ColorPickerState {
  final PantoneColor pickedColor;
  final List<PantoneColor> closestPantoneColors;
  final Offset position;
  // final File image;

  const ColorPickedState(this.pickedColor, this.closestPantoneColors, this.position);

  @override
  // TODO: implement props
  List<Object?> get props => [pickedColor, closestPantoneColors, position];
}

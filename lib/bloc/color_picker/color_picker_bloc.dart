import 'dart:io';
import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image/image.dart' as img;
import 'package:pantone_book/model/pantone_model.dart';
import '../../repository/color_repository.dart';

part 'color_picker_event.dart';
part 'color_picker_state.dart';

class ColorPickerBloc extends Bloc<ColorPickerEvent, ColorPickerState> {
  final ColorRepository _colorRepository = ColorRepository();

  ColorPickerBloc() : super(ColorPickerInitial()) {

    on<ColorPickedEvent>((event, emit) async {
      final img.Pixel extractedColor = await _colorRepository.onTapDown(event.image, event.position, event.scrollController, event.context);
      final PantoneColor color = PantoneColor(id: 1, pantoneCode: "", colorName: "Touched", red: extractedColor.r.toInt(), green: extractedColor.g.toInt(), blue: extractedColor.b.toInt());
      final List<PantoneColor> closestPantoneColors = await _colorRepository.getClosestPantoneColors(extractedColor);
      emit(ColorPickedState(color, closestPantoneColors, event.position));
    });

    // on<CameraImageSelectedEvent>((event, emit) {
    //   final File image = _imageRepository.compressAndResizeImage(event.image);
    //   emit(ImageLoadedState(image));
    // });
    //
    // on<GalleryImageSelectedEvent>((event, emit) {
    //   final File image = _imageRepository.compressAndResizeImage(event.image);
    //   emit(ImageLoadedState(image));
    // });
  }
}

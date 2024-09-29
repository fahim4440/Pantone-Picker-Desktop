import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pantone_book/model/pantone_model.dart';
import 'package:pantone_book/services/pantone_database/pantone_db.dart';

part 'color_search_event.dart';
part 'color_search_state.dart';

class ColorSearchBloc extends Bloc<ColorSearchEvent, ColorSearchState> {
  ColorSearchBloc() : super(ColorSearchInitial()) {
    on<ColorSearchTriggerEvent>((event, emit) async {
      try {
        if (event.query.length < 2) {
          emit(ColorSearchInitial());
        } else {
          emit(ColorSearchLoadingState());
          final List<PantoneColor> allColors = await PantoneColorDatabase.instance.fetchAllPantoneColors();
          final List<PantoneColor> filteredColors = allColors.where((color) =>
          color.colorName.toLowerCase().contains(event.query.toLowerCase()) ||
              color.pantoneCode.toLowerCase().contains(event.query.toLowerCase())
          ).toList();
          emit(ColorSearchLoadedState(filteredColors));
        }
      } catch(error) {
        emit(ColorSearchErrorState(error.toString()));
      }
    });
  }
}

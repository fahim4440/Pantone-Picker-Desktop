import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/search_color/color_search_bloc.dart';

TextField SearchColorTextField(BuildContext context) {
  return TextField(
    onChanged: (String query) {
      BlocProvider.of<ColorSearchBloc>(context).add(
          ColorSearchTriggerEvent(query));
    },
    decoration: const InputDecoration(
      suffixIcon: Icon(Icons.search),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent, width: 6.0),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0),
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0),
        ),
      ),
      focusColor: Colors.blueGrey,
      labelText: "Search Pantone",
      labelStyle: TextStyle(
        color: Colors.blueGrey,
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
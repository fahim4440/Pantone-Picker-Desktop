import 'package:flutter/material.dart';
import '../model/pantone_model.dart';

AlertDialog AlertColorCard(BuildContext context, PantoneColor color) {
  return AlertDialog(
    title: Text(color.colorName),
    content: Container(
      width: MediaQuery.of(context).size.width - 100.0,
      height: 300.0,
      color: Color.fromARGB(255, color.red, color.green, color.blue),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SelectableText(
          color.pantoneCode,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
      ),
    ),
  );
}
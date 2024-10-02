import 'package:flutter/material.dart';
import '../model/pantone_model.dart';

Column ColorCard(PantoneColor color) {
  return Column(
    children: [
      Container(
        margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        width: 100,
        height: 85,
        color: Color.fromARGB(255, color.red, color.green, color.blue),
      ),
      Container(
        margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
        width: 100,
        height: 15.0,
        color: Color.fromARGB(200, color.red, color.green, color.blue),
        child: Center(child: Text("${color.red}, ${color.green}, ${color.blue}", style: const TextStyle(fontSize: 12.0),)),
      ),
      color.pantoneCode == "" ? const SizedBox() : SelectableText(color.pantoneCode),
      SelectableText(color.colorName),
    ],
  );
}
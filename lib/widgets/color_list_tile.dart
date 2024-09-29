import 'package:flutter/material.dart';
import '../model/pantone_model.dart';

Container ColorListTile(BuildContext context, PantoneColor color) {
  return Container(
    margin: const EdgeInsets.only(left: 15.0, right: 15.0),
    width: MediaQuery.of(context).size.width,
    height: 50.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(color.colorName),
            const SizedBox(
              height: 5.0,
            ),
            Text(color.pantoneCode),
          ],
        ),
        Container(
          height: 40.0,
          width: 40.0,
          color: Color.fromARGB(255, color.red, color.green, color.blue),
        ),
      ],
    ),
  );
}

import 'package:flutter/material.dart';
import '../model/pantone_model.dart';

Card ColorListTile(BuildContext context, PantoneColor color) {
  return Card(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
    ),
    color: Color.fromARGB(255, color.red, color.green, color.blue),
    child: Container(
      margin: const EdgeInsets.only(left: 15.0, right: 15.0),
      // width: MediaQuery.of(context).size.width,
      // height: 50.0,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(color.colorName, style: const TextStyle(fontSize: 30.0),),
            const SizedBox(
              height: 5.0,
            ),
            Text(color.pantoneCode),
          ],
        ),
      ),
    ),
  );
}

import 'package:flutter/material.dart';

Row GreetingsCard(String name) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const Icon(
        Icons.person_pin,
        color: Colors.blueGrey,
        size: 80.0,
      ),
      const SizedBox(
        width: 10.0,
      ),
      Text(
        "Hi, $name",
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

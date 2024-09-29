import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

TypewriterAnimatedText AnimatedTextWidget(String text) {
  return TypewriterAnimatedText(
    text,
    textStyle: const TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),
    speed: const Duration(milliseconds: 150),
    textAlign: TextAlign.center,
  );
}
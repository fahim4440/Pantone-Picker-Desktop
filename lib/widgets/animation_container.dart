import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'animated_text.dart';

Container AnimationContainer() {
  return Container(
    height: 500.0,
    margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 30.0,),
    child: Align(
      alignment: Alignment.center,
      child: AnimatedTextKit(
        animatedTexts: [
          AnimatedTextWidget('You can search matching pantone colors'),
          AnimatedTextWidget('By Pantone Code'),
          AnimatedTextWidget('By Pantone Name'),
          AnimatedTextWidget('By Image'),
        ],
        totalRepeatCount: 100,
      ),
    ),
  );
}
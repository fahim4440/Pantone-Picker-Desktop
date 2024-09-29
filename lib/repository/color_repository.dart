import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:pantone_book/model/pantone_model.dart';
import '../services/pantone_database/pantone_db.dart';

class ColorRepository {
  Future<img.Pixel> onTapDown(File file, Offset localPosition, ScrollController scrollController, BuildContext context) async {

    final img.Image? image = img.decodeImage(await file.readAsBytes());

    if (image != null) {
      // Get the RenderBox and size of the image displayed on the screen
      final RenderBox box = context.findRenderObject() as RenderBox;
      final Size imageSize = box.size;

      // double zoomScale = photoViewController.scale ?? 1.0;
      // print("Zoom scale is $zoomScale");
      //
      // // Calculate scale ratio of the displayed image vs. actual image dimensions
      // double scaleX = image.width / imageSize.width;
      // double scaleY = image.height / imageSize.height;
      //
      // // Use the correct scale factor (if the image might scale differently in width and height)
      // double scale = scaleX > scaleY ? scaleX : scaleY;
      // print('Normal scaling is $scaleX');
      //
      // // Print debug information
      // print('Local Tap Position: ${localPosition.dx}, ${localPosition.dy}');
      // print('Image Size on Screen: ${imageSize.width}, ${imageSize.height}');
      //
      // // Get the scroll offset
      // double scrollOffset = scrollController.offset;
      //
      // Offset position = photoViewController.position;
      // print('Zoom Tap Position: ${position.dx}, ${position.dy}');
      //
      // // Adjust the touch coordinates based on scale and position
      // double x = (localPosition.dx + ((zoomScale - 1) * image.width) / 2 + position.dx) * scaleX;
      // double y = (localPosition.dy + ((zoomScale - 1) * image.height) / 2 - position.dy) * scaleX;
      //
      // print('Mapped Coordinates (with zoom scaling): $x, $y');
      // print('Scroll Offset: $scrollOffset');
      // print('Original Image Size: ${image.width}, ${image.height}');


      // Original Without Zoom
      double scaleX = image.width / imageSize.width;
      print("Normal scale = $scaleX");
      print('Local position: x=${localPosition.dx}, y=${localPosition.dy}');
      print('Displayed Image size: ${imageSize.width}x${imageSize.height}');
      print('Original Image size: ${image.width}x${image.height}');

      // Get the scroll offset
      double scrollOffset = scrollController.offset;

      // Get x, y coordinates relative to image resolution
      int x = (localPosition.dx * scaleX).toInt();
      int y = ((localPosition.dy) * scaleX).toInt();
      print('Mapped: x=$x, y=$y');
      // print(scrollOffset);


      // Ensure coordinates are within image bounds
      if (x >= 0 && x < image.width && y >= 0 && y < image.height) {
        // Get the pixel color at (x, y)
        img.Pixel pixelColor = image.getPixel(x.toInt(), y.toInt());
        return pixelColor;
      }
    }
    return throw();
  }

  Future<List<PantoneColor>> getClosestPantoneColors(img.Pixel extractedColor) async {
    List<PantoneColor> closestPantoneColors = await fetchMatchingPantoneColors(Color.fromRGBO(extractedColor.r.toInt(), extractedColor.g.toInt(), extractedColor.b.toInt(), 1.0));
    return closestPantoneColors;
  }

  Future<List<PantoneColor>> fetchMatchingPantoneColors(Color extractedColor) async {
    List<PantoneColor> allPantoneColors = await PantoneColorDatabase.instance.fetchAllPantoneColors();

    allPantoneColors.sort((a, b) {
      double distanceA = colorDistance(
          extractedColor.red, extractedColor.green, extractedColor.blue,
          a.red, a.green, a.blue
      );
      double distanceB = colorDistance(
          extractedColor.red, extractedColor.green, extractedColor.blue,
          b.red, b.green, b.blue
      );
      return distanceA.compareTo(distanceB);
    });

    return allPantoneColors.take(5).toList();
  }

  // Calculate color distance (Euclidean distance in RGB space)
  double colorDistance(int r1, int g1, int b1, int r2, int g2, int b2) {
    return (r1 - r2) * (r1 - r2) +
        (g1 - g2) * (g1 - g2) +
        (b1 - b2) * (b1 - b2).toDouble();
  }
}
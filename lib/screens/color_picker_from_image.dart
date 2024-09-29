import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/pantone_model.dart';
import '../bloc/color_picker/color_picker_bloc.dart';
import '../widgets/color_card.dart';

// ignore: must_be_immutable
class ColorPickerFromImage extends StatelessWidget {
  File image;
  ColorPickerFromImage(this.image, {super.key});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pick A Color"),),
      body: BlocProvider(
        create: (context) => ColorPickerBloc(),
        child: BlocBuilder<ColorPickerBloc, ColorPickerState>(
          builder: (context, state) {
            if (state is ColorPickedState) {
              return SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                          onTapDown: (details) {
                            context.read<ColorPickerBloc>().add(ColorPickedEvent(image, details.localPosition, _scrollController, context));
                          },
                          child: Image.file(image),
                        ),
                        Positioned(
                          left: state.position.dx,
                          top: state.position.dy - 40,
                          child: const Icon(Icons.colorize, size: 40, color: Colors.red,),
                        ),
                      ]
                    ),
                    const SizedBox(height: 10.0,),
                    ColorCard(state.pickedColor),
                    const SizedBox(height: 10.0,),
                    SizedBox(
                      height: 170.0,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: state.closestPantoneColors.length,
                        itemBuilder: (BuildContext context, int index) {
                          PantoneColor color = state.closestPantoneColors[index];
                          return Row(
                            children: [
                              ColorCard(color),
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            }
            return SingleChildScrollView(
              controller: _scrollController,
              child: GestureDetector(
                onTapDown: (details) {
                  context.read<ColorPickerBloc>().add(ColorPickedEvent(image, details.localPosition, _scrollController, context));
                  },
                child: Image.file(image),
              ),
            );
            // return const Center(child: CircularProgressIndicator(),);
          }
        ),
      ),
    );
  }
}


// class ColorPickerFromImage extends StatefulWidget {
//   final File image;
//
//   const ColorPickerFromImage({super.key, required this.image});
//
//   @override
//   State<ColorPickerFromImage> createState() => _ColorPickerFromImageState();
// }
//
// class _ColorPickerFromImageState extends State<ColorPickerFromImage> {
//
//   final ScrollController _scrollController = ScrollController();
//   final PhotoViewController _photoViewController = PhotoViewController();
//
//
//   // List<PantoneColor> closestPantoneColors = [];
//   // PantoneColor? extractedColor;
//   // bool matchingDone = false;
//   //
//   // // Calculate color distance (Euclidean distance in RGB space)
//   // double colorDistance(int r1, int g1, int b1, int r2, int g2, int b2) {
//   //   return (r1 - r2) * (r1 - r2) +
//   //       (g1 - g2) * (g1 - g2) +
//   //       (b1 - b2) * (b1 - b2).toDouble();
//   // }
//   //
//   //
//   // Future<List<PantoneColor>> fetchMatchingPantoneColors(Color extractedColor) async {
//   //   List<PantoneColor> allPantoneColors = await PantoneColorDatabase.instance.fetchAllPantoneColors();
//   //
//   //   allPantoneColors.sort((a, b) {
//   //     double distanceA = colorDistance(
//   //         extractedColor.red, extractedColor.green, extractedColor.blue,
//   //         a.red, a.green, a.blue
//   //     );
//   //     double distanceB = colorDistance(
//   //         extractedColor.red, extractedColor.green, extractedColor.blue,
//   //         b.red, b.green, b.blue
//   //     );
//   //     return distanceA.compareTo(distanceB);
//   //   });
//   //
//   //   return allPantoneColors.take(5).toList();
//   // }
//   //
//   //
//   // Future<void> _onTapDown(Offset localPosition, BuildContext context) async {
//   //   final img.Image? image = img.decodeImage(await widget.image.readAsBytes());
//   //
//   //   if (image != null) {
//   //     // Get the RenderBox and size of the image displayed on the screen
//   //     final RenderBox box = context.findRenderObject() as RenderBox;
//   //     final Size imageSize = box.size;
//   //
//   //     double zoomScale = _photoViewController.scale ?? 1.0;
//   //     print("Zoom scale is $zoomScale");
//   //
//   //     // Calculate scale ratio of the displayed image vs. actual image dimensions
//   //     double scaleX = image.width / imageSize.width;
//   //     double scaleY = image.height / imageSize.height;
//   //
//   //     // Use the correct scale factor (if the image might scale differently in width and height)
//   //     double scale = scaleX > scaleY ? scaleX : scaleY;
//   //     print('Normal scaling is $scaleX');
//   //
//   //     // Print debug information
//   //     print('Local Tap Position: ${localPosition.dx}, ${localPosition.dy}');
//   //     print('Image Size on Screen: ${imageSize.width}, ${imageSize.height}');
//   //
//   //     // Get the scroll offset
//   //     double scrollOffset = _scrollController.offset;
//   //
//   //     Offset position = _photoViewController.position;
//   //     print('Zoom Tap Position: ${position.dx}, ${position.dy}');
//   //
//   //     // Adjust the touch coordinates based on scale and position
//   //     double x = (localPosition.dx + ((zoomScale - 1) * image.width) / 2 + position.dx) * scaleX;
//   //     double y = (localPosition.dy + ((zoomScale - 1) * image.height) / 2 - position.dy) * scaleX;
//   //
//   //     print('Mapped Coordinates (with zoom scaling): $x, $y');
//   //     print('Scroll Offset: $scrollOffset');
//   //     print('Original Image Size: ${image.width}, ${image.height}');
//   //
//   //
//   //     //Original Without Zoom
//   //     // double scaleX = image.width / imageSize.width;
//   //     // print("Normal scale = $scaleX");
//   //     // print('Local position: x=${localPosition.dx}, y=${localPosition.dy}');
//   //     // print('Displayed Image size: ${imageSize.width}x${imageSize.height}');
//   //     // print('Original Image size: ${image.width}x${image.height}');
//   //     //
//   //     // // Get the scroll offset
//   //     // double scrollOffset = _scrollController.offset;
//   //     //
//   //     // // Get x, y coordinates relative to image resolution
//   //     // int x = (localPosition.dx * scaleX).toInt();
//   //     // int y = ((localPosition.dy) * scaleX).toInt();
//   //     // print('Mapped: x=$x, y=$y');
//   //     // print(scrollOffset);
//   //
//   //
//   //     // Ensure coordinates are within image bounds
//   //     if (x >= 0 && x < image.width && y >= 0 && y < image.height) {
//   //       // Get the pixel color at (x, y)
//   //       img.Pixel pixelColor = image.getPixel(x.toInt(), y.toInt());
//   //       extractedColor = PantoneColor(id: 1, pantoneCode: "", colorName: "Touched", red: pixelColor.r.toInt(), green: pixelColor.g.toInt(), blue: pixelColor.b.toInt());
//   //       closestPantoneColors = await fetchMatchingPantoneColors(Color.fromRGBO(pixelColor.r.toInt(), pixelColor.g.toInt(), pixelColor.b.toInt(), 1.0));
//   //       setState(() {
//   //         matchingDone = true;
//   //       });
//   //     }
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Pick a Color')),
//       body: SingleChildScrollView(
//         controller: _scrollController,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             GestureDetector(
//               onTapDown: (tapDownDetails) {
//                 _onTapDown(tapDownDetails.localPosition, context);
//               },
//               child: SizedBox(
//                 width: MediaQuery.of(context).size.width,
//                 height: 600,
//                 child: ClipRect(
//                   child: PhotoView(
//                     controller: _photoViewController,
//                     imageProvider: FileImage(widget.image,),
//                     initialScale: PhotoViewComputedScale.covered,
//                   ),
//                 ),
//               ),
//               // child: Image.file(widget.image)
//             ),
//             // Add logic to touch and pick color from the image
//             // For example, you might want to display a widget for color selection here
//             const SizedBox(height: 10.0,),
//             extractedColor != null ? Column(
//               children: [
//                 Container(
//                   margin: const EdgeInsets.all(10.0),
//                   width: 100,
//                   height: 100,
//                   color: Color.fromARGB(255, extractedColor!.red, extractedColor!.green, extractedColor!.blue),
//                 ),
//                 Text(extractedColor!.colorName),
//               ],
//             ) : const SizedBox(),
//             const SizedBox(height: 10.0,),
//             matchingDone ? SizedBox(
//               height: 150.0,
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 scrollDirection: Axis.horizontal,
//                 itemCount: closestPantoneColors.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   PantoneColor color = closestPantoneColors[index];
//                   return Row(
//                     children: [
//                       const SizedBox(width: 10.0,),
//                       Column(
//                         children: [
//                           Container(
//                             width: 100,
//                             height: 100,
//                             color: Color.fromARGB(255, color.red, color.green, color.blue),
//                           ),
//                           Text(color.pantoneCode),
//                           Text(color.colorName),
//                         ],
//                       ),
//                       const SizedBox(width: 10.0,),
//                     ],
//                   );
//                 },
//               ),
//             ) : const SizedBox(),
//           ],
//         ),
//       ),
//     );
//   }
// }

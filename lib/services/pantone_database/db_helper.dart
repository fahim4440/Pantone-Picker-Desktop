import 'dart:io';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import '../../model/pantone_model.dart';
import 'pantone_db.dart';

class PantoneDBHelper {
  Future<void> initializePantoneDatabase() async {
    // Load Pantone colors only if database is empty
    await loadPantoneColorsIfNeeded();
  }

  Future<void> loadPantoneColorsIfNeeded() async {
    // Check if the database is already loaded
    bool isLoaded = await PantoneColorDatabase.instance.isDatabaseLoaded();

    if (!isLoaded) {
      print("Database is empty. Loading Pantone colors from Excel...");
      // Insert Pantone colors from the Excel file
      await insertPantoneColorsToDatabase();
      print("Pantone colors successfully loaded into the database.");
    } else {
      print("Database already contains Pantone colors. No need to load.");
    }
  }

  Future<void> insertPantoneColorsToDatabase() async {
    // Read colors from Excel
    List<PantoneColor> pantoneColors = await readPantoneColorsFromExcel();

    // Insert each Pantone color into the database
    for (PantoneColor color in pantoneColors) {
      await PantoneColorDatabase.instance.insertPantoneColor(color);
    }
  }

  Future<List<PantoneColor>> readPantoneColorsFromExcel() async {
    // Load the Excel file from the assets
    ByteData data = await rootBundle.load('assets/Pantone_RGB.xlsx');

    // Write the file to a temporary location because the 'excel' package works with files
    var bytes = data.buffer.asUint8List();
    var tempDir = await getTemporaryDirectory();
    File tempFile = File('${tempDir.path}/pantone_colors.xlsx');
    await tempFile.writeAsBytes(bytes, flush: true);

    // Read the Excel file
    // final bytes = excelFile.readAsBytesSync();
    final excel = Excel.decodeBytes(bytes);

    List<PantoneColor> pantoneColors = [];

    // Assuming the data is in the first sheet
    final sheet = excel.tables[excel.tables.keys.first];

    if (sheet != null) {
      int colorId = 0;
      for (var row in sheet.rows.skip(1)) {  // Skip header row
        String colorName = row[0]!.value.toString();
        String pantoneCode = row[1]!.value.toString();
        // String RGB = row[3]!.value.toString();
        // List<int> rgbInt = getRGBFromString(RGB.trim());
        int red = int.parse(row[2]!.value.toString());
        int green = int.parse(row[3]!.value.toString());
        int blue = int.parse(row[4]!.value.toString());

        PantoneColor color = PantoneColor(
          id: colorId,  // SQLite will auto-generate ID
          pantoneCode: pantoneCode,
          colorName: colorName,
          red: red,
          green: green,
          blue: blue,
        );
        pantoneColors.add(color);
        colorId++;
      }
    }

    return pantoneColors;
  }
}
class PantoneColor {
  final int id;
  final String pantoneCode;
  final String colorName;
  final int red;
  final int green;
  final int blue;

  PantoneColor({
    required this.id,
    required this.pantoneCode,
    required this.colorName,
    required this.red,
    required this.green,
    required this.blue,
  });

  // Convert PantoneColor to a Map (to be used for database operations)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pantone_code': pantoneCode,
      'color_name': colorName,
      'red': red,
      'green': green,
      'blue': blue,
    };
  }

  // Create PantoneColor from a Map
  factory PantoneColor.fromMap(Map<String, dynamic> map) {
    return PantoneColor(
      id: map['id'],
      pantoneCode: map['pantone_code'],
      colorName: map['color_name'],
      red: map['red'],
      green: map['green'],
      blue: map['blue'],
    );
  }
}

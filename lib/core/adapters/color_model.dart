import 'dart:ui';

import 'package:hive/hive.dart';

part 'color_model.g.dart';

@HiveType(typeId: 8) // لازم ID فريد ومختلف عن أي موديل تاني
class ColorModel extends HiveObject {
  @HiveField(0)
  final int value; // هخزن اللون كـ int (زي Color.value)

  ColorModel(this.value);

  // تقدر تعمل getter يرجع Color من dart:ui
  Color get color => Color(value);
}

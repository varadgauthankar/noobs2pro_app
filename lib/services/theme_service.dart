import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:noobs2pro_app/constants/hive_boxes.dart';

class ThemeService {
  Box<int> box = Hive.box<int>(kThemeBox);

  ThemeMode get theme => _getThemeFromBox();

  void saveThemeToBox(ThemeMode mode) {
    box.put('key', mode.index);
  }

  ThemeMode _getThemeFromBox() {
    final int? value = box.get('key');
    if (value != null) {
      return ThemeMode.values[value];
    }
    return ThemeMode.light;
  }
}

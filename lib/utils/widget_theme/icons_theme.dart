import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class VAIconTheme {
  VAIconTheme._();

  /// -- Light Theme
  static var lightIconTheme = const IconThemeData(
    color: VAAccentColor,
    size: 25.0,
  );

  /// -- Dark Theme
  static var darkIconTheme = const IconThemeData(
    color: VAPrimaryColor,
    size: 25.0,
  );
}

import 'package:flutter/material.dart';
import 'package:visit_amhara_admin_app/utils/widget_theme/icons_theme.dart';
import 'package:visit_amhara_admin_app/utils/widget_theme/text_theme.dart';

class VAAppTheme {
  VAAppTheme._();
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      textTheme: VATextTheme.lightTextTheme,
      iconTheme: VAIconTheme.lightIconTheme);

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      textTheme: VATextTheme.darkTextTheme,
      iconTheme: VAIconTheme.darkIconTheme);
}

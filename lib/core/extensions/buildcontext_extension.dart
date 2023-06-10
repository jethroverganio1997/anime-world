import 'package:flutter/material.dart';

extension ScreenSize on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double widthPercent(double widthPercent) => MediaQuery.of(this).size.width * widthPercent;
  double heightPercent(double heightPercent) => MediaQuery.of(this).size.height * heightPercent;
}

extension ExtensionTheme on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  TextTheme get primaryTextTheme => Theme.of(this).primaryTextTheme;
}

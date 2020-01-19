import 'dart:ui';

import 'package:flutter/widgets.dart';

class ColorTheme {
  const ColorTheme({
    @required this.brightness,
    @required this.background,
    @required this.text,
    @required this.primary,
  })  : assert(brightness != null),
        assert(background != null),
        assert(text != null),
        assert(primary != null);

  final Brightness brightness;
  final Color background;
  final Color text;
  final Color primary;
}

class ColorThemeProvider extends InheritedWidget {
  const ColorThemeProvider({
    Key key,
    Widget child,
    @required this.theme,
  })  : assert(theme != null),
        super(key: key, child: child);

  final ColorTheme theme;

  static ColorTheme of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ColorThemeProvider>()
        .theme;
  }

  @override
  bool updateShouldNotify(ColorThemeProvider oldWidget) {
    return oldWidget.theme != theme;
  }
}

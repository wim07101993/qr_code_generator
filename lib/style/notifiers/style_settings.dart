import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class StyleSettingsNotifier extends ValueNotifier<StyleSettings> {
  StyleSettingsNotifier() : super(StyleSettings());
}

class StyleSettings {
  static const defaultBackgroundColor = Colors.white;
  static const defaultDataModuleStyle = QrDataModuleStyle(
    dataModuleShape: QrDataModuleShape.square,
    color: Colors.black,
  );
  static const defaultEyeStyle = QrEyeStyle(
    eyeShape: QrEyeShape.square,
    color: Colors.black,
  );
  static const defaultGapless = true;

  StyleSettings({
    this.backgroundColor = defaultBackgroundColor,
    this.dataModuleStyle = defaultDataModuleStyle,
    this.embeddedImageFilePath,
    this.embeddedImageStyle,
    this.eyeStyle = defaultEyeStyle,
    this.gapless = defaultGapless,
  });

  final Color backgroundColor;
  final QrDataModuleStyle dataModuleStyle;
  final String? embeddedImageFilePath;
  final QrEmbeddedImageStyle? embeddedImageStyle;
  final QrEyeStyle eyeStyle;
  final bool gapless;

  ImageProvider? get embeddedImage {
    final path = embeddedImageFilePath;
    return path == null ? null : FileImage(File(path));
  }

  StyleSettings copyWithBackgroundColor(Color backgroundColor) {
    return StyleSettings(
      backgroundColor: backgroundColor,
      dataModuleStyle: dataModuleStyle,
      embeddedImageFilePath: embeddedImageFilePath,
      embeddedImageStyle: embeddedImageStyle,
      eyeStyle: eyeStyle,
      gapless: gapless,
    );
  }

  StyleSettings copyWithDataModuleStyle(
    QrDataModuleStyle dataModuleStyle,
  ) {
    return StyleSettings(
      backgroundColor: backgroundColor,
      dataModuleStyle: dataModuleStyle,
      embeddedImageFilePath: embeddedImageFilePath,
      embeddedImageStyle: embeddedImageStyle,
      eyeStyle: eyeStyle,
      gapless: gapless,
    );
  }

  StyleSettings copyWithEmbeddedImageFilePath(
    String? embeddedImageFilePath,
  ) {
    return StyleSettings(
      backgroundColor: backgroundColor,
      dataModuleStyle: dataModuleStyle,
      embeddedImageFilePath: embeddedImageFilePath,
      embeddedImageStyle: embeddedImageStyle,
      eyeStyle: eyeStyle,
      gapless: gapless,
    );
  }

  StyleSettings copyWithEmbeddedImageStyle(
    QrEmbeddedImageStyle? embeddedImageStyle,
  ) {
    return StyleSettings(
      backgroundColor: backgroundColor,
      dataModuleStyle: dataModuleStyle,
      embeddedImageFilePath: embeddedImageFilePath,
      embeddedImageStyle: embeddedImageStyle,
      eyeStyle: eyeStyle,
      gapless: gapless,
    );
  }

  StyleSettings copyWithEyeStyle(QrEyeStyle eyeStyle) {
    return StyleSettings(
      backgroundColor: backgroundColor,
      dataModuleStyle: dataModuleStyle,
      embeddedImageFilePath: embeddedImageFilePath,
      embeddedImageStyle: embeddedImageStyle,
      eyeStyle: eyeStyle,
      gapless: gapless,
    );
  }

  StyleSettings copyWithGapless({required bool gapless}) {
    return StyleSettings(
      backgroundColor: backgroundColor,
      dataModuleStyle: dataModuleStyle,
      embeddedImageFilePath: embeddedImageFilePath,
      embeddedImageStyle: embeddedImageStyle,
      eyeStyle: eyeStyle,
      gapless: gapless,
    );
  }

  ThemeData toThemeData() {
    final isDark = isDarkColor(backgroundColor);
    final textColor = isDark ? Colors.white : Colors.black;
    return ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: createMaterialColor(
          dataModuleStyle.color ?? Colors.black,
        ),
        accentColor: createMaterialColor(eyeStyle.color ?? Colors.black),
        backgroundColor: backgroundColor,
        cardColor: backgroundColor,
        brightness: isDark ? Brightness.dark : Brightness.light,
      ),
      textTheme: TextTheme(
        bodyText1: TextStyle(color: textColor),
        bodyText2: TextStyle(color: textColor),
        headline1: TextStyle(color: textColor),
        headline2: TextStyle(color: textColor),
        headline3: TextStyle(color: textColor),
        headline4: TextStyle(color: textColor),
        headline5: TextStyle(color: textColor),
        headline6: TextStyle(color: textColor),
        button: TextStyle(color: textColor),
        caption: TextStyle(color: textColor),
        overline: TextStyle(color: textColor),
        subtitle1: TextStyle(color: textColor),
        subtitle2: TextStyle(color: textColor),
      ),
    );
  }
}

MaterialColor createMaterialColor(Color color) {
  final strengths = <double>[.05];
  final swatch = <int, Color>{};
  final r = color.red, g = color.green, b = color.blue;

  for (var i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (final strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

bool isDarkColor(Color color) {
  final colorArray = [color.red, color.green, color.blue].map((e) {
    final v = e.toDouble() / 255;
    if (v <= 0.03928) {
      return v / 12.92;
    }

    return pow((v + 0.055) / 1.055, 2.4);
  }).toList();

  final luminance =
      0.2126 * colorArray[0] + 0.7152 * colorArray[1] + 0.0722 * colorArray[2];
  return luminance <= 0.179;
}

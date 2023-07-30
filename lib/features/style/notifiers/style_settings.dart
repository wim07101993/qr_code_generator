import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

export 'package:flutter/material.dart' show Color, Size;
export 'package:qr_flutter/qr_flutter.dart';

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
    this.embeddedImage,
    this.embeddedImageStyle,
    this.eyeStyle = defaultEyeStyle,
    this.gapless = defaultGapless,
  });

  final Color backgroundColor;
  final QrDataModuleStyle dataModuleStyle;
  final ImageProvider? embeddedImage;
  final QrEmbeddedImageStyle? embeddedImageStyle;
  final QrEyeStyle eyeStyle;
  final bool gapless;

  StyleSettings copyWithBackgroundColor(Color backgroundColor) {
    return StyleSettings(
      backgroundColor: backgroundColor,
      dataModuleStyle: dataModuleStyle,
      embeddedImage: embeddedImage,
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
      embeddedImage: embeddedImage,
      embeddedImageStyle: embeddedImageStyle,
      eyeStyle: eyeStyle,
      gapless: gapless,
    );
  }

  StyleSettings copyWithEmbeddedImage(ImageProvider? embeddedImage) {
    return StyleSettings(
      backgroundColor: backgroundColor,
      dataModuleStyle: dataModuleStyle,
      embeddedImage: embeddedImage,
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
      embeddedImage: embeddedImage,
      embeddedImageStyle: embeddedImageStyle,
      eyeStyle: eyeStyle,
      gapless: gapless,
    );
  }

  StyleSettings copyWithEyeStyle(QrEyeStyle eyeStyle) {
    return StyleSettings(
      backgroundColor: backgroundColor,
      dataModuleStyle: dataModuleStyle,
      embeddedImage: embeddedImage,
      embeddedImageStyle: embeddedImageStyle,
      eyeStyle: eyeStyle,
      gapless: gapless,
    );
  }

  StyleSettings copyWithGapless({required bool gapless}) {
    return StyleSettings(
      backgroundColor: backgroundColor,
      dataModuleStyle: dataModuleStyle,
      embeddedImage: embeddedImage,
      embeddedImageStyle: embeddedImageStyle,
      eyeStyle: eyeStyle,
      gapless: gapless,
    );
  }

  ThemeData toThemeData() {
    final isDark = isDarkColor(backgroundColor);
    final textColor = isDark ? Colors.white : Colors.black;
    final primaryColor = dataModuleStyle.color ?? Colors.black;
    return ThemeData(
      appBarTheme: AppBarTheme(
        color: Colors.transparent,
        foregroundColor: primaryColor,
      ),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: createMaterialColor(primaryColor),
        accentColor: createMaterialColor(eyeStyle.color ?? Colors.black),
        backgroundColor: backgroundColor,
        cardColor: backgroundColor,
        brightness: isDark ? Brightness.dark : Brightness.light,
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(color: textColor),
        headlineMedium: TextStyle(color: textColor),
        headlineSmall: TextStyle(color: textColor),
        titleLarge: TextStyle(color: textColor),
        titleMedium: TextStyle(color: textColor),
        titleSmall: TextStyle(color: textColor),
        displayLarge: TextStyle(color: textColor),
        displayMedium: TextStyle(color: textColor),
        displaySmall: TextStyle(color: textColor),
        bodyLarge: TextStyle(color: textColor),
        bodyMedium: TextStyle(color: textColor),
        bodySmall: TextStyle(color: textColor),
        labelLarge: TextStyle(color: textColor),
        labelMedium: TextStyle(color: textColor),
        labelSmall: TextStyle(color: textColor),
      ),
    );
  }
}

MaterialColor createMaterialColor(Color color) {
  final strengths = <double>[.05];
  final swatch = <int, Color>{};
  final r = color.red;
  final g = color.green;
  final b = color.blue;

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

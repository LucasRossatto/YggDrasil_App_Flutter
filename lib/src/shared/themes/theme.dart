import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromRGBO(5, 223, 114, 1),
      surfaceTint: Color(0xFF25C45E),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff05df72),
      onPrimaryContainer: Color(0xff005d2b),
      secondary: Color(0xFFE4E4E4),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff0d542b),
      onSecondaryContainer: Color(0xff84c793),
      tertiary: Color(0xff006d34),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff05df72),
      onTertiaryContainer: Color(0xff005d2b),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffcf8f8),
      onSurface: Color.fromRGBO(11, 12, 13, 1),
      onSurfaceVariant: Color(0xff444748),
      outline: Color(0xff747878),
      outlineVariant: Color(0xffc4c7c7),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color.fromRGBO(5, 223, 114, 1),
      primaryFixed: Color(0xff62ff96),
      onPrimaryFixed: Color(0xff00210b),
      primaryFixedDim: Color(0xff18e376),
      onPrimaryFixedVariant: Color(0xff005226),
      secondaryFixed: Color(0xffadf2bb),
      onSecondaryFixed: Color(0xff00210c),
      secondaryFixedDim: Color(0xff92d6a0),
      onSecondaryFixedVariant: Color(0xff095229),
      tertiaryFixed: Color(0xff62ff96),
      onTertiaryFixed: Color(0xff00210b),
      tertiaryFixedDim: Color(0xff18e376),
      onTertiaryFixedVariant: Color(0xff005226),
      surfaceDim: Color(0xffddd9d9),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f3f2),
      surfaceContainer: Color(0xfff1edec),
      surfaceContainerHigh: Color(0xffebe7e7),
      surfaceContainerHighest: Color(0xffe5e2e1),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff00401c),
      surfaceTint: Color(0xff006d34),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff007e3d),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff003b1b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff0d542b),
      onSecondaryContainer: Color(0xffaef4bc),
      tertiary: Color(0xff00401c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff007e3d),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff111111),
      onSurfaceVariant: Color(0xff333737),
      outline: Color(0xff4f5354),
      outlineVariant: Color(0xff6a6e6e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color.fromRGBO(5, 223, 114, 1),
      primaryFixed: Color(0xff007e3d),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff00622e),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff397a4d),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff1e6136),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff007e3d),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff00622e),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc9c6c5),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f3f2),
      surfaceContainer: Color(0xffebe7e7),
      surfaceContainerHigh: Color(0xffdfdcdb),
      surfaceContainerHighest: Color(0xffd4d1d0),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003416),
      surfaceTint: Color(0xff006d34),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff005527),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff003417),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff0d542b),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff003416),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff005527),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff292d2d),
      outlineVariant: Color(0xff464a4a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xff18e376),
      primaryFixed: Color(0xff005527),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003c1a),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff0e542b),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff003b1b),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff005527),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff003c1a),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffbbb8b7),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff4f0ef),
      surfaceContainer: Color(0xffe5e2e1),
      surfaceContainerHigh: Color(0xffd7d4d3),
      surfaceContainerHighest: Color(0xffc9c6c5),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color.fromRGBO(5, 223, 114, 1),
      surfaceTint: Color(0xFF25C45E),
      onPrimary: Color(0xff003918),
      primaryContainer: Color(0xff05df72),
      onPrimaryContainer: Color(0xff005d2b),
      secondary: Color(0xFF3F4759),
      onSecondary: Color(0xff003919),
      secondaryContainer: Color(0xff0d542b),
      onSecondaryContainer: Color(0xff84c793),
      tertiary: Color(0xff46fc8b),
      onTertiary: Color(0xff003918),
      tertiaryContainer: Color(0xff05df72),
      onTertiaryContainer: Color(0xff005d2b),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff141313),
      onSurface: Color.fromARGB(255, 255, 255, 255),
      onSurfaceVariant: Color(0xffc4c7c7),
      outline: Color(0xff8e9192),
      outlineVariant: Color(0xff444748),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff006d34),
      primaryFixed: Color(0xff62ff96),
      onPrimaryFixed: Color(0xff00210b),
      primaryFixedDim: Color(0xff18e376),
      onPrimaryFixedVariant: Color(0xff005226),
      secondaryFixed: Color(0xffadf2bb),
      onSecondaryFixed: Color(0xff00210c),
      secondaryFixedDim: Color(0xff92d6a0),
      onSecondaryFixedVariant: Color(0xff095229),
      tertiaryFixed: Color(0xff62ff96),
      onTertiaryFixed: Color(0xff00210b),
      tertiaryFixedDim: Color(0xff18e376),
      onTertiaryFixedVariant: Color(0xff005226),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff3a3939),
      surfaceContainerLowest: Color(0xff0e0e0e),
      surfaceContainerLow: Color(0xff1c1b1b),
      surfaceContainer: Color(0xff201f1f),
      surfaceContainerHigh: Color(0xff2a2a2a),
      surfaceContainerHighest: Color(0xff353434),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color.fromRGBO(5, 223, 114, 1),
      surfaceTint: Color(0xFF25C45E),
      onPrimary: Color(0xff002e12),
      primaryContainer: Color(0xff05df72),
      onPrimaryContainer: Color(0xff003c1a),
      secondary: Color(0xffa7ecb5),
      onSecondary: Color(0xff002d13),
      secondaryContainer: Color(0xff5d9f6e),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xff46fc8b),
      onTertiary: Color(0xff002e12),
      tertiaryContainer: Color(0xff05df72),
      onTertiaryContainer: Color(0xff003c1a),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff141313),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffdadddd),
      outline: Color(0xffafb2b3),
      outlineVariant: Color(0xff8d9191),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff005427),
      primaryFixed: Color(0xff62ff96),
      onPrimaryFixed: Color(0xff001506),
      primaryFixedDim: Color(0xff18e376),
      onPrimaryFixedVariant: Color(0xff00401c),
      secondaryFixed: Color(0xffadf2bb),
      onSecondaryFixed: Color(0xff001506),
      secondaryFixedDim: Color(0xff92d6a0),
      onSecondaryFixedVariant: Color(0xff003f1d),
      tertiaryFixed: Color(0xff62ff96),
      onTertiaryFixed: Color(0xff001506),
      tertiaryFixedDim: Color(0xff18e376),
      onTertiaryFixedVariant: Color(0xff00401c),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff454444),
      surfaceContainerLowest: Color(0xff070707),
      surfaceContainerLow: Color(0xff1e1d1d),
      surfaceContainer: Color(0xff282828),
      surfaceContainerHigh: Color(0xff333232),
      surfaceContainerHighest: Color(0xff3e3d3d),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffc0ffc9),
      surfaceTint: Color(0xff18e376),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff05df72),
      onPrimaryContainer: Color(0xff000e03),
      secondary: Color(0xffc0ffcb),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xff8ed29d),
      onSecondaryContainer: Color(0xff000f04),
      tertiary: Color(0xffc0ffc9),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xff05df72),
      onTertiaryContainer: Color(0xff000e03),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff141313),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffeef0f1),
      outlineVariant: Color(0xffc0c3c4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff005427),
      primaryFixed: Color(0xff62ff96),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff18e376),
      onPrimaryFixedVariant: Color(0xff001506),
      secondaryFixed: Color(0xffadf2bb),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xff92d6a0),
      onSecondaryFixedVariant: Color(0xff001506),
      tertiaryFixed: Color(0xff62ff96),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xff18e376),
      onTertiaryFixedVariant: Color(0xff001506),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff51504f),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff201f1f),
      surfaceContainer: Color(0xff313030),
      surfaceContainerHigh: Color(0xff3c3b3b),
      surfaceContainerHighest: Color(0xff484646),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     appBarTheme: AppBarTheme(
       backgroundColor: colorScheme.surface,
       foregroundColor: colorScheme.onSurface,
       iconTheme: IconThemeData(color: colorScheme.onSurface),
       titleTextStyle: textTheme.titleLarge?.apply(color: colorScheme.onSurface),
       centerTitle: true,
       elevation: 0,
     ),
     scaffoldBackgroundColor: colorScheme.surface,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}

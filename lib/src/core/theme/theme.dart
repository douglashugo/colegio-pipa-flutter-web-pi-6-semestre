import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4287320099),
      surfaceTint: Color(4287320099),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4294958278),
      onPrimaryContainer: Color(4281406208),
      secondary: Color(4282146960),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4292142079),
      onSecondaryContainer: Color(4278197306),
      tertiary: Color(4284506420),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4293256877),
      onTertiaryContainer: Color(4280032512),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      surface: Color(4294965493),
      onSurface: Color(4280424981),
      onSurfaceVariant: Color(4283581500),
      outline: Color(4286870634),
      outlineVariant: Color(4292330423),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281871913),
      inversePrimary: Color(4294948742),
      primaryFixed: Color(4294958278),
      onPrimaryFixed: Color(4281406208),
      primaryFixedDim: Color(4294948742),
      onPrimaryFixedVariant: Color(4285413645),
      secondaryFixed: Color(4292142079),
      onSecondaryFixed: Color(4278197306),
      secondaryFixedDim: Color(4289120511),
      onSecondaryFixedVariant: Color(4280436854),
      tertiaryFixed: Color(4293256877),
      onTertiaryFixed: Color(4280032512),
      tertiaryFixedDim: Color(4291414675),
      onTertiaryFixedVariant: Color(4282927391),
      surfaceDim: Color(4293384142),
      surfaceBright: Color(4294965493),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294963690),
      surfaceContainer: Color(4294765538),
      surfaceContainerHigh: Color(4294370780),
      surfaceContainerHighest: Color(4293976023),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4285084937),
      surfaceTint: Color(4287320099),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4289029431),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4280108146),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4283659943),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4282664219),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4285953864),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      surface: Color(4294965493),
      onSurface: Color(4280424981),
      onSurfaceVariant: Color(4283318328),
      outline: Color(4285226067),
      outlineVariant: Color(4287133550),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281871913),
      inversePrimary: Color(4294948742),
      primaryFixed: Color(4289029431),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4287122721),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4283659943),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4282015117),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4285953864),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4284309298),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4293384142),
      surfaceBright: Color(4294965493),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294963690),
      surfaceContainer: Color(4294765538),
      surfaceContainerHigh: Color(4294370780),
      surfaceContainerHighest: Color(4293976023),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4282063104),
      surfaceTint: Color(4287320099),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4285084937),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4278198854),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4280108146),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4280493056),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4282664219),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      surface: Color(4294965493),
      onSurface: Color(4278190080),
      onSurfaceVariant: Color(4281147930),
      outline: Color(4283318328),
      outlineVariant: Color(4283318328),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281871913),
      inversePrimary: Color(4294961370),
      primaryFixed: Color(4285084937),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4283048192),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4280108146),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4278201688),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4282664219),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4281151239),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4293384142),
      surfaceBright: Color(4294965493),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294963690),
      surfaceContainer: Color(4294765538),
      surfaceContainerHigh: Color(4294370780),
      surfaceContainerHighest: Color(4293976023),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294948742),
      surfaceTint: Color(4294948742),
      onPrimary: Color(4283442176),
      primaryContainer: Color(4285413645),
      onPrimaryContainer: Color(4294958278),
      secondary: Color(4289120511),
      onSecondary: Color(4278268254),
      secondaryContainer: Color(4280436854),
      onSecondaryContainer: Color(4292142079),
      tertiary: Color(4291414675),
      onTertiary: Color(4281414154),
      tertiaryContainer: Color(4282927391),
      onTertiaryContainer: Color(4293256877),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      surface: Color(4279833101),
      onSurface: Color(4293976023),
      onSurfaceVariant: Color(4292330423),
      outline: Color(4288646531),
      outlineVariant: Color(4283581500),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293976023),
      inversePrimary: Color(4287320099),
      primaryFixed: Color(4294958278),
      onPrimaryFixed: Color(4281406208),
      primaryFixedDim: Color(4294948742),
      onPrimaryFixedVariant: Color(4285413645),
      secondaryFixed: Color(4292142079),
      onSecondaryFixed: Color(4278197306),
      secondaryFixedDim: Color(4289120511),
      onSecondaryFixedVariant: Color(4280436854),
      tertiaryFixed: Color(4293256877),
      onTertiaryFixed: Color(4280032512),
      tertiaryFixedDim: Color(4291414675),
      onTertiaryFixedVariant: Color(4282927391),
      surfaceDim: Color(4279833101),
      surfaceBright: Color(4282464049),
      surfaceContainerLowest: Color(4279504136),
      surfaceContainerLow: Color(4280424981),
      surfaceContainer: Color(4280688153),
      surfaceContainerHigh: Color(4281411619),
      surfaceContainerHighest: Color(4282200877),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294950032),
      surfaceTint: Color(4294948742),
      onPrimary: Color(4280880896),
      primaryContainer: Color(4291199312),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4289580287),
      onSecondary: Color(4278195761),
      secondaryContainer: Color(4285567686),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4291677847),
      onTertiary: Color(4279703552),
      tertiaryContainer: Color(4287861858),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      surface: Color(4279833101),
      onSurface: Color(4294966008),
      onSurfaceVariant: Color(4292593596),
      outline: Color(4289896341),
      outlineVariant: Color(4287725686),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293976023),
      inversePrimary: Color(4285479438),
      primaryFixed: Color(4294958278),
      onPrimaryFixed: Color(4280355584),
      primaryFixedDim: Color(4294948742),
      onPrimaryFixedVariant: Color(4284033280),
      secondaryFixed: Color(4292142079),
      onSecondaryFixed: Color(4278194472),
      secondaryFixedDim: Color(4289120511),
      onSecondaryFixedVariant: Color(4278925157),
      tertiaryFixed: Color(4293256877),
      onTertiaryFixed: Color(4279308800),
      tertiaryFixedDim: Color(4291414675),
      onTertiaryFixedVariant: Color(4281808912),
      surfaceDim: Color(4279833101),
      surfaceBright: Color(4282464049),
      surfaceContainerLowest: Color(4279504136),
      surfaceContainerLow: Color(4280424981),
      surfaceContainer: Color(4280688153),
      surfaceContainerHigh: Color(4281411619),
      surfaceContainerHighest: Color(4282200877),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294966008),
      surfaceTint: Color(4294948742),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4294950032),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294703871),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4289580287),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294901444),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4291677847),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      surface: Color(4279833101),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294966008),
      outline: Color(4292593596),
      outlineVariant: Color(4292593596),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293976023),
      inversePrimary: Color(4282785536),
      primaryFixed: Color(4294959568),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4294950032),
      onPrimaryFixedVariant: Color(4280880896),
      secondaryFixed: Color(4292601855),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4289580287),
      onSecondaryFixedVariant: Color(4278195761),
      tertiaryFixed: Color(4293585585),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4291677847),
      onTertiaryFixedVariant: Color(4279703552),
      surfaceDim: Color(4279833101),
      surfaceBright: Color(4282464049),
      surfaceContainerLowest: Color(4279504136),
      surfaceContainerLow: Color(4280424981),
      surfaceContainer: Color(4280688153),
      surfaceContainerHigh: Color(4281411619),
      surfaceContainerHighest: Color(4282200877),
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
     scaffoldBackgroundColor: colorScheme.background,
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

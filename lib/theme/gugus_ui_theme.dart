import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';

/// Styling tokens and helpers for Pip UI frosted glass aesthetic.
class PipUiTheme {
  const PipUiTheme._();

  // Primary Accent Colors
  static const Color primaryLight = Color(0xff0066ff);
  static const Color primaryDark = Color(0xff4d94ff);

  // Success / Trend Colors
  static const Color successLight = Color(0xff22c55e);
  static const Color successDark = Color(0xff30d158);
  static const Color dangerLight = Color(0xffef4444);
  static const Color dangerDark = Color(0xffff453a);

  // Surface and Glass Colors
  static Color glassBackground(BuildContext context, {double? lightAlpha, double? darkAlpha}) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    if (dark) {
      return const Color(0xff1e212a).withValues(alpha: darkAlpha ?? 0.82);
    } else {
      return Colors.white.withValues(alpha: lightAlpha ?? 0.80);
    }
  }

  static Color glassFloatingBackground(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return dark
        ? const Color(0xff1e1e22).withValues(alpha: 0.58)
        : Colors.white.withValues(alpha: 0.62);
  }

  static Color glassBorder(BuildContext context, {double? lightAlpha, double? darkAlpha}) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    if (dark) {
      return const Color(0xff2e3342).withValues(alpha: darkAlpha ?? 0.75);
    } else {
      return Colors.white.withValues(alpha: lightAlpha ?? 0.85);
    }
  }

  static Color glassControlBorder(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return dark
        ? Colors.white.withValues(alpha: 0.26)
        : Colors.white.withValues(alpha: 0.70);
  }

  static Color mutedText(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return dark ? const Color(0xff7a8294) : const Color(0xff7e8699);
  }

  // Box Shadows
  static List<BoxShadow> glassShadows(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return [
      BoxShadow(
        color: dark
            ? Colors.black.withValues(alpha: 0.38)
            : Colors.black.withValues(alpha: 0.07),
        blurRadius: 24,
        spreadRadius: -4,
        offset: const Offset(0, 10),
      ),
      BoxShadow(
        color: dark
            ? Colors.black.withValues(alpha: 0.22)
            : Colors.black.withValues(alpha: 0.03),
        blurRadius: 8,
        spreadRadius: -2,
        offset: const Offset(0, 4),
      ),
    ];
  }

  static List<BoxShadow> controlShadows(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return [
      BoxShadow(
        color: dark
            ? Colors.white.withValues(alpha: 0.12)
            : Colors.white.withValues(alpha: 0.85),
        blurRadius: 14,
        spreadRadius: 0.5,
        offset: Offset.zero,
      ),
      BoxShadow(
        color: Colors.black.withValues(alpha: dark ? 0.40 : 0.13),
        blurRadius: 24,
        spreadRadius: -2,
        offset: const Offset(0, 8),
      ),
      BoxShadow(
        color: Colors.black.withValues(alpha: dark ? 0.22 : 0.05),
        blurRadius: 8,
        spreadRadius: -1,
        offset: const Offset(0, 2),
      ),
    ];
  }

  // Backdrop filter
  static ImageFilter defaultBlur({double sigma = 30.0}) =>
      ImageFilter.blur(sigmaX: sigma, sigmaY: sigma);
}

import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import '../theme/pip_ui_theme.dart';

/// A standalone frosted glass floating pill/circle container control.
///
/// Features:
/// - Frosted glass backdrop blur
/// - Ambient multi-layer depth shadows
/// - Tactile border and splash feedback
/// - Fully customizable padding, borderRadius, blur sigma, and colors
class PipFloatingGlassControl extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final bool showShadow;
  final double blurSigma;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;

  const PipFloatingGlassControl({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(2),
    this.onTap,
    this.showShadow = true,
    this.blurSigma = 30.0,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final effectiveRadius = borderRadius ?? BorderRadius.circular(99);
    final resolvedBg = backgroundColor ??
        (dark
            ? const Color(0xff1e1e22).withValues(alpha: 0.58)
            : Colors.white.withValues(alpha: 0.62));
    final resolvedBorder = borderColor ??
        (dark
            ? Colors.white.withValues(alpha: 0.26)
            : Colors.white.withValues(alpha: 0.70));

    return Semantics(
      button: onTap != null,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: effectiveRadius,
            boxShadow: showShadow ? PipUiTheme.controlShadows(context) : const [],
          ),
          child: ClipRRect(
            borderRadius: effectiveRadius,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: resolvedBg,
                  borderRadius: effectiveRadius,
                  border: Border.all(color: resolvedBorder, width: 0.9),
                ),
                child: Padding(
                  padding: padding,
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A standalone circular floating glass icon button (e.g. for header actions,
/// settings, close, refresh).
class PipGlassIconButton extends StatelessWidget {
  final Widget? icon;
  final IconData? iconData;
  final VoidCallback? onPressed;
  final String? tooltip;
  final double size;
  final double iconSize;
  final Color? iconColor;
  final Color? backgroundColor;
  final bool showShadow;

  const PipGlassIconButton({
    super.key,
    this.icon,
    this.iconData,
    required this.onPressed,
    this.tooltip,
    this.size = 38.0,
    this.iconSize = 18.0,
    this.iconColor,
    this.backgroundColor,
    this.showShadow = true,
  }) : assert(icon != null || iconData != null, 'Provide either icon or iconData');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resolvedIconColor =
        iconColor ?? theme.colorScheme.onSurfaceVariant;

    final buttonWidget = IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      iconSize: iconSize,
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(
        minWidth: size,
        minHeight: size,
        maxWidth: size,
        maxHeight: size,
      ),
      icon: icon ??
          Icon(
            iconData,
            size: iconSize,
            color: resolvedIconColor,
          ),
    );

    return PipFloatingGlassControl(
      padding: const EdgeInsets.all(2),
      showShadow: showShadow,
      backgroundColor: backgroundColor,
      child: buttonWidget,
    );
  }
}

/// Minimalist 3-stacked horizontal lines hamburger icon.
class PipMenuLinesIcon extends StatelessWidget {
  final Color? color;
  final double width;
  final double lineHeight;
  final double height;

  const PipMenuLinesIcon({
    super.key,
    this.color,
    this.width = 15.0,
    this.lineHeight = 1.8,
    this.height = 11.0,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedColor = color ?? Theme.of(context).colorScheme.onSurfaceVariant;

    return SizedBox(
      width: width,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: width,
            height: lineHeight,
            decoration: BoxDecoration(
              color: resolvedColor,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          Container(
            width: width,
            height: lineHeight,
            decoration: BoxDecoration(
              color: resolvedColor,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          Container(
            width: width,
            height: lineHeight,
            decoration: BoxDecoration(
              color: resolvedColor,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

/// Style variants or reveal modes for [GugusCopyright].
enum GugusCopyrightMode {
  /// Footer remains statically visible at [GugusCopyright.opacity].
  fixed,

  /// Footer smoothly animates its opacity when [GugusCopyright.isRevealed] toggles.
  gradual,
}

/// A standalone, configurable copyright and creator footer component.
///
/// Supports customizable icons (such as the default heart icon), tagline ('Made with love'),
/// legal/copyright text, custom styling, opacity control, and gradual scroll-revealed or fixed modes.
class GugusCopyright extends StatelessWidget {
  /// Primary copyright message (e.g., 'gugus. Software&Things © 2026').
  final String copyright;

  /// Optional tagline shown directly above the copyright text (e.g., 'Made with love').
  final String? tagline;

  /// Custom widget replacing the default icon. If provided, [iconData] is ignored.
  final Widget? icon;

  /// IconData to display above the tagline. Defaults to [Icons.favorite_rounded].
  final IconData? iconData;

  /// Whether to show the top icon. Defaults to `true`.
  final bool showIcon;

  /// Color of the icon. Defaults to [Colors.redAccent].
  final Color? iconColor;

  /// Size of the icon. Defaults to `15.0`.
  final double iconSize;

  /// Text style for the [tagline].
  final TextStyle? taglineStyle;

  /// Text style for the [copyright] notice.
  final TextStyle? copyrightStyle;

  /// Alignment of text elements. Defaults to [TextAlign.center].
  final TextAlign textAlign;

  /// Spacing between the icon and the tagline. Defaults to `6.0`.
  final double spacing;

  /// Spacing between the tagline and copyright text. Defaults to `3.0`.
  final double lineSpacing;

  /// Inner padding around the footer content.
  final EdgeInsetsGeometry? padding;

  /// Main axis size for the column. Defaults to [MainAxisSize.min].
  final MainAxisSize mainAxisSize;

  /// Cross axis alignment for the content column. Defaults to [CrossAxisAlignment.center].
  final CrossAxisAlignment crossAxisAlignment;

  /// Optional manual override for dark or light theme colors.
  /// If null, brightness is inferred from [Theme.of(context)].
  final bool? isDark;

  /// Target opacity of the footer (0.0 to 1.0). Defaults to `1.0`.
  final double opacity;

  /// Whether the footer gradually animates opacity based on [isRevealed].
  ///
  /// When `true`, transitions are animated with [animationDuration] and [animationCurve].
  /// When `false`, the footer sits statically (fixed) at [opacity].
  final bool graduallyRevealed;

  /// Visibility state when [graduallyRevealed] is true.
  ///
  /// If `true`, animates towards [opacity].
  /// If `false`, animates towards `0.0`.
  final bool isRevealed;

  /// Duration for opacity transitions in gradual reveal mode. Defaults to 200ms.
  final Duration animationDuration;

  /// Curve for opacity transitions in gradual reveal mode. Defaults to [Curves.easeOut].
  final Curve animationCurve;

  final TextStyle? _customStyle;

  /// Standard configurable constructor for [GugusCopyright].
  const GugusCopyright({
    super.key,
    String? text,
    String? copyright,
    this.tagline = 'Made with love',
    this.icon,
    this.iconData = Icons.favorite_rounded,
    this.showIcon = true,
    this.iconColor = Colors.redAccent,
    this.iconSize = 15.0,
    this.taglineStyle,
    this.copyrightStyle,
    TextStyle? style,
    this.textAlign = TextAlign.center,
    this.spacing = 6.0,
    this.lineSpacing = 3.0,
    this.padding,
    this.mainAxisSize = MainAxisSize.min,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.isDark,
    this.opacity = 1.0,
    this.graduallyRevealed = false,
    this.isRevealed = true,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeOut,
  })  : copyright = copyright ?? text ?? 'gugus. Software&Things © 2026',
        _customStyle = style;

  /// Fixed mode constructor: the footer sits statically without reveal animations.
  const GugusCopyright.fixed({
    super.key,
    String? text,
    String? copyright,
    this.tagline = 'Made with love',
    this.icon,
    this.iconData = Icons.favorite_rounded,
    this.showIcon = true,
    this.iconColor = Colors.redAccent,
    this.iconSize = 15.0,
    this.taglineStyle,
    this.copyrightStyle,
    TextStyle? style,
    this.textAlign = TextAlign.center,
    this.spacing = 6.0,
    this.lineSpacing = 3.0,
    this.padding,
    this.mainAxisSize = MainAxisSize.min,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.isDark,
    this.opacity = 1.0,
  })  : graduallyRevealed = false,
        isRevealed = true,
        animationDuration = const Duration(milliseconds: 200),
        animationCurve = Curves.easeOut,
        copyright = copyright ?? text ?? 'gugus. Software&Things © 2026',
        _customStyle = style;

  /// Revealed mode constructor: the footer animates its opacity gradually based on [isRevealed].
  const GugusCopyright.revealed({
    super.key,
    required this.isRevealed,
    String? text,
    String? copyright,
    this.tagline = 'Made with love',
    this.icon,
    this.iconData = Icons.favorite_rounded,
    this.showIcon = true,
    this.iconColor = Colors.redAccent,
    this.iconSize = 15.0,
    this.taglineStyle,
    this.copyrightStyle,
    TextStyle? style,
    this.textAlign = TextAlign.center,
    this.spacing = 6.0,
    this.lineSpacing = 3.0,
    this.padding,
    this.mainAxisSize = MainAxisSize.min,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.isDark,
    this.opacity = 1.0,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeOut,
  })  : graduallyRevealed = true,
        copyright = copyright ?? text ?? 'gugus. Software&Things © 2026',
        _customStyle = style;

  /// Convenience utility to determine if a vertical scroll view is at the bottom.
  ///
  /// Useful with [NotificationListener<ScrollNotification>] to toggle [isRevealed].
  static bool isScrollAtBottom(
    ScrollNotification notification, {
    double threshold = 14.0,
  }) {
    if (notification.metrics.axis != Axis.vertical) return false;
    return notification.metrics.extentAfter <= threshold;
  }

  @override
  Widget build(BuildContext context) {
    final effectiveDark =
        isDark ?? (Theme.of(context).brightness == Brightness.dark);

    final defaultTaglineStyle = TextStyle(
      color: effectiveDark
          ? const Color(0xFF9CA3AF)
          : const Color(0xFF6B7280),
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );

    final defaultCopyrightStyle = _customStyle ??
        TextStyle(
          color: effectiveDark
              ? const Color(0xFF6B7280)
              : const Color(0xFF9CA3AF),
          fontSize: 11,
        );

    final resolvedTaglineStyle =
        taglineStyle != null ? defaultTaglineStyle.merge(taglineStyle) : defaultTaglineStyle;

    final resolvedCopyrightStyle = copyrightStyle != null
        ? defaultCopyrightStyle.merge(copyrightStyle)
        : defaultCopyrightStyle;

    Widget content = Column(
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        if (showIcon) ...[
          icon ??
              Icon(
                iconData ?? Icons.favorite_rounded,
                color: iconColor ?? Colors.redAccent,
                size: iconSize,
              ),
          SizedBox(height: spacing),
        ],
        if (tagline != null && tagline!.isNotEmpty) ...[
          Text(
            tagline!,
            textAlign: textAlign,
            style: resolvedTaglineStyle,
          ),
          if (copyright.isNotEmpty) SizedBox(height: lineSpacing),
        ],
        if (copyright.isNotEmpty)
          Text(
            copyright,
            textAlign: textAlign,
            style: resolvedCopyrightStyle,
          ),
      ],
    );

    if (padding != null) {
      content = Padding(padding: padding!, child: content);
    }

    final clampedOpacity = opacity.clamp(0.0, 1.0);

    if (graduallyRevealed) {
      final targetOpacity = isRevealed ? clampedOpacity : 0.0;
      return IgnorePointer(
        ignoring: !isRevealed || targetOpacity == 0.0,
        child: AnimatedOpacity(
          opacity: targetOpacity,
          duration: animationDuration,
          curve: animationCurve,
          child: content,
        ),
      );
    }

    if (clampedOpacity < 1.0) {
      return Opacity(
        opacity: clampedOpacity,
        child: content,
      );
    }

    return content;
  }
}

/// Alias for [GugusCopyright] following gugus UI design naming conventions.
typedef PipCopyright = GugusCopyright;

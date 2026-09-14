import 'package:flutter/material.dart';
import 'gugus_glass_button.dart';

/// Style variants for [PipActionButton].
enum PipButtonVariant {
  primary,
  secondary,
  glass,
  outline,
  ghost,
}

/// A modern button component matching gugus UI aesthetics with various style variants,
/// loading spinner support, icons, and customizable borders.
class PipActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final PipButtonVariant variant;
  final IconData? icon;
  final Widget? leading;
  final Widget? trailing;
  final bool isLoading;
  final bool fullWidth;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final Color? customColor;
  final Color? customTextColor;

  const PipActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = PipButtonVariant.primary,
    this.icon,
    this.leading,
    this.trailing,
    this.isLoading = false,
    this.fullWidth = false,
    this.padding,
    this.borderRadius = 14.0,
    this.customColor,
    this.customTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;
    final primary = customColor ?? theme.colorScheme.primary;

    final effectivePadding = padding ??
        const EdgeInsets.symmetric(horizontal: 20, vertical: 13);

    Widget content() {
      if (isLoading) {
        return SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              variant == PipButtonVariant.primary ? Colors.white : primary,
            ),
          ),
        );
      }

      return Row(
        mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: 8),
          ] else if (icon != null) ...[
            Icon(icon, size: 18),
            const SizedBox(width: 8),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.2,
              color: customTextColor,
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: 8),
            trailing!,
          ],
        ],
      );
    }

    Widget button;

    switch (variant) {
      case PipButtonVariant.primary:
        button = FilledButton(
          onPressed: isLoading ? null : onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: primary,
            foregroundColor: customTextColor ?? Colors.white,
            padding: effectivePadding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            elevation: 0,
          ),
          child: content(),
        );
        break;

      case PipButtonVariant.secondary:
        button = FilledButton.tonal(
          onPressed: isLoading ? null : onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: customColor ?? theme.colorScheme.surfaceContainer,
            foregroundColor: customTextColor ?? theme.colorScheme.onSurface,
            padding: effectivePadding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            elevation: 0,
          ),
          child: content(),
        );
        break;

      case PipButtonVariant.glass:
        return PipFloatingGlassControl(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          padding: effectivePadding,
          child: content(),
        );

      case PipButtonVariant.outline:
        button = OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: customTextColor ?? theme.colorScheme.onSurface,
            side: BorderSide(
              color: customColor ??
                  (dark
                      ? Colors.white.withValues(alpha: 0.22)
                      : Colors.black.withValues(alpha: 0.12)),
              width: 1.0,
            ),
            padding: effectivePadding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          child: content(),
        );
        break;

      case PipButtonVariant.ghost:
        button = TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            foregroundColor: customTextColor ?? primary,
            padding: effectivePadding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          child: content(),
        );
        break;
    }

    if (fullWidth) {
      return SizedBox(
        width: double.infinity,
        child: button,
      );
    }

    return button;
  }
}

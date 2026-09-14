import 'dart:ui' show FontFeature;
import 'package:flutter/material.dart';

/// A sleek pill badge showing metric trend changes with up/down arrows
/// and colored positive/negative visual feedback.
class PipTrendBadge extends StatelessWidget {
  /// The percentage change (e.g. 14.5 for +14.5%, -3.2 for -3.2%).
  final double change;

  /// Whether a lower value represents improvement (e.g. churn rate, crash rate).
  final bool lowerIsBetter;

  /// Custom positive color override.
  final Color? positiveColor;

  /// Custom negative color override.
  final Color? negativeColor;

  /// Optional prefix or suffix format (e.g. '+' prefix).
  final bool showPlusSign;

  const PipTrendBadge({
    super.key,
    required this.change,
    this.lowerIsBetter = false,
    this.positiveColor,
    this.negativeColor,
    this.showPlusSign = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!change.isFinite) return const SizedBox.shrink();
    final isGood = lowerIsBetter ? change <= 0 : change >= 0;
    final dark = Theme.of(context).brightness == Brightness.dark;

    final defaultPos = dark ? const Color(0xff30d158) : const Color(0xff22c55e);
    final defaultNeg = dark ? const Color(0xffff453a) : const Color(0xffef4444);

    final color = isGood
        ? (positiveColor ?? defaultPos)
        : (negativeColor ?? defaultNeg);

    final bgColor = isGood
        ? (positiveColor?.withValues(alpha: 0.15) ??
            (dark
                ? const Color(0xff30d158).withValues(alpha: 0.15)
                : const Color(0xff22c55e).withValues(alpha: 0.12)))
        : (negativeColor?.withValues(alpha: 0.15) ??
            (dark
                ? const Color(0xffff453a).withValues(alpha: 0.15)
                : const Color(0xffef4444).withValues(alpha: 0.12)));

    final isUp = change >= 0;

    return Semantics(
      label:
          '${isUp ? 'Increased' : 'Decreased'} ${change.abs().toStringAsFixed(1)} percent',
      excludeSemantics: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              isUp ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
              size: 11,
              color: color,
            ),
            const SizedBox(width: 2.5),
            Text(
              '${isUp && showPlusSign ? '+' : ''}${change.abs().toStringAsFixed(1)}%',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 11.5,
                color: color,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

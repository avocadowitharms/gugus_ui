import 'dart:ui' show ImageFilter;
import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import '../theme/pip_ui_theme.dart';

/// Navigation item model for [PipGlassNavBar].
class PipNavItem {
  final String label;
  final IconData icon;
  final IconData? selectedIcon;
  final String? badge;
  final String? tooltip;

  const PipNavItem({
    required this.label,
    required this.icon,
    this.selectedIcon,
    this.badge,
    this.tooltip,
  });
}

/// A standalone floating frosted glass capsule navigation bar.
///
/// Features:
/// - Frosted glass backdrop filter with configurable blur
/// - Multi-layer subtle depth shadows
/// - Animated selection capsule and scale transitions
/// - Customizable colors, dimensions, borders, and item widths
/// - Standalone: works in any Flutter application with any navigation framework
class PipGlassNavBar extends StatelessWidget {
  final List<PipNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  final double height;
  final double itemWidth;
  final double selectedWidth;
  final double blurSigma;
  final Color? backgroundColor;
  final Color? selectedBackgroundColor;
  final Color? borderColor;
  final Color? activeColor;
  final Color? inactiveColor;
  final bool showShadow;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;

  const PipGlassNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.height = 58.0,
    this.itemWidth = 62.0,
    this.selectedWidth = 60.0,
    this.blurSigma = 30.0,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.borderColor,
    this.activeColor,
    this.inactiveColor,
    this.showShadow = true,
    this.margin,
    this.borderRadius,
  });

  /// Default preset for Pip Stats style with Overview and Reviews tabs.
  factory PipGlassNavBar.preset({
    Key? key,
    required int currentIndex,
    required ValueChanged<int> onTap,
    List<PipNavItem>? customItems,
    Color? activeColor,
    Color? backgroundColor,
  }) {
    return PipGlassNavBar(
      key: key,
      currentIndex: currentIndex,
      onTap: onTap,
      activeColor: activeColor,
      backgroundColor: backgroundColor,
      items: customItems ??
          const [
            PipNavItem(
              label: 'Overview',
              icon: CupertinoIcons.chart_bar,
              selectedIcon: CupertinoIcons.chart_bar_alt_fill,
            ),
            PipNavItem(
              label: 'Reviews',
              icon: CupertinoIcons.chat_bubble_2,
              selectedIcon: CupertinoIcons.chat_bubble_2_fill,
            ),
          ],
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(items.isNotEmpty, 'PipGlassNavBar requires at least one item');
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;

    final resolvedAccent = activeColor ?? theme.colorScheme.primary;
    final resolvedMuted = inactiveColor ?? PipUiTheme.mutedText(context);
    final resolvedBg = backgroundColor ?? PipUiTheme.glassBackground(context);
    final resolvedBorder = borderColor ?? PipUiTheme.glassBorder(context);
    final resolvedSelectedBg = selectedBackgroundColor ??
        (dark
            ? resolvedAccent.withValues(alpha: 0.22)
            : resolvedAccent.withValues(alpha: 0.16));

    final verticalInset = (height * 0.103).clamp(4.0, 8.0);
    final effectiveRadius = borderRadius ?? BorderRadius.circular(height / 2);
    final selectedHeight = height - verticalInset * 2;
    final selectedRadius = (height / 2) - verticalInset;

    final calculatedWidth = items.length * itemWidth + 12.0;
    final barWidth = calculatedWidth.clamp(136.0, 480.0);
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return Padding(
      padding: margin ??
          EdgeInsets.only(
            bottom: bottomPadding > 0 ? bottomPadding : 14,
            left: 16,
            right: 16,
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: barWidth,
            height: height,
            decoration: BoxDecoration(
              borderRadius: effectiveRadius,
              boxShadow: showShadow ? PipUiTheme.glassShadows(context) : const [],
            ),
            child: ClipRRect(
              borderRadius: effectiveRadius,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
                child: Container(
                  decoration: BoxDecoration(
                    color: resolvedBg,
                    borderRadius: effectiveRadius,
                    border: Border.all(color: resolvedBorder, width: 1.5),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Row(
                    children: [
                      for (var i = 0; i < items.length; i++)
                        Expanded(
                          child: _PipNavButton(
                            item: items[i],
                            selected: i == currentIndex,
                            selectedColor: resolvedSelectedBg,
                            activeColor: resolvedAccent,
                            inactiveColor: resolvedMuted,
                            selectedHeight: selectedHeight,
                            selectedRadius: selectedRadius,
                            selectedWidth: selectedWidth,
                            iconSize: 26,
                            inactiveIconSize: 24,
                            onTap: () => onTap(i),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PipNavButton extends StatelessWidget {
  final PipNavItem item;
  final bool selected;
  final Color selectedColor;
  final Color activeColor;
  final Color inactiveColor;
  final double selectedHeight;
  final double selectedRadius;
  final double selectedWidth;
  final double iconSize;
  final double inactiveIconSize;
  final VoidCallback onTap;

  const _PipNavButton({
    required this.item,
    required this.selected,
    required this.selectedColor,
    required this.activeColor,
    required this.inactiveColor,
    required this.selectedHeight,
    required this.selectedRadius,
    required this.selectedWidth,
    required this.iconSize,
    required this.inactiveIconSize,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final foreground = selected ? activeColor : inactiveColor;

    return Tooltip(
      message: item.tooltip ?? item.label,
      child: Semantics(
        button: true,
        selected: selected,
        label: item.label,
        child: Center(
          child: SizedBox(
            width: selectedWidth,
            height: selectedHeight,
            child: Material(
              type: MaterialType.transparency,
              borderRadius: BorderRadius.circular(selectedRadius),
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(selectedRadius),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOutCubic,
                  width: selectedWidth,
                  height: selectedHeight,
                  decoration: BoxDecoration(
                    color: selected ? selectedColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(selectedRadius),
                  ),
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        Icon(
                          selected ? (item.selectedIcon ?? item.icon) : item.icon,
                          color: foreground,
                          size: selected ? iconSize : inactiveIconSize,
                        ),
                        if (item.badge != null && item.badge!.isNotEmpty)
                          Positioned(
                            top: -2,
                            right: -6,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 1.5,
                              ),
                              decoration: BoxDecoration(
                                color: activeColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 14,
                                minHeight: 14,
                              ),
                              child: Text(
                                item.badge!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

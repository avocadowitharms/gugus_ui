import 'package:flutter/material.dart';

/// A sleek, customizable segmented control with smooth animated pills,
/// frosted surface styling, and optional icon and extended label animations.
///
/// Can be used with any custom type [T].
class PipSegmentedTabs<T> extends StatelessWidget {
  /// The list of items / options.
  final List<T> items;

  /// The currently selected item.
  final T selected;

  /// Callback when a new item is tapped.
  final ValueChanged<T> onChanged;

  /// Returns the standard text label for each item.
  final String Function(T item) labelBuilder;

  /// Optional label to display only when the item is active (e.g. "7D" -> "Week").
  final String Function(T item)? extendedLabelBuilder;

  /// Optional icon builder for each item.
  final IconData Function(T item)? iconBuilder;

  /// Whether the control stretches to fill its parent container width.
  final bool fullWidth;

  /// Background container color of the track.
  final Color? backgroundColor;

  /// Background color of the active tab pill.
  final Color? activePillColor;

  /// Text & icon color of the active tab.
  final Color? activeTextColor;

  /// Text & icon color of inactive tabs.
  final Color? inactiveTextColor;

  /// Accent color for active icons.
  final Color? activeIconColor;

  /// Border radius of the entire control and active pill.
  final BorderRadius? borderRadius;

  /// Padding around the track.
  final EdgeInsetsGeometry padding;

  /// Border around the track.
  final BoxBorder? border;

  const PipSegmentedTabs({
    super.key,
    required this.items,
    required this.selected,
    required this.onChanged,
    required this.labelBuilder,
    this.extendedLabelBuilder,
    this.iconBuilder,
    this.fullWidth = false,
    this.backgroundColor,
    this.activePillColor,
    this.activeTextColor,
    this.inactiveTextColor,
    this.activeIconColor,
    this.borderRadius,
    this.padding = const EdgeInsets.all(3.0),
    this.border,
  });

  /// Convenient constructor accepting `values`
  factory PipSegmentedTabs.fromValues({
    Key? key,
    required List<T> values,
    required T selected,
    required ValueChanged<T> onChanged,
    required String Function(T item) labelBuilder,
    String Function(T item)? extendedLabelBuilder,
    IconData Function(T item)? iconBuilder,
    bool fullWidth = false,
    Color? backgroundColor,
    Color? activePillColor,
    Color? activeTextColor,
    Color? inactiveTextColor,
    Color? activeIconColor,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry padding = const EdgeInsets.all(3.0),
    BoxBorder? border,
  }) =>
      PipSegmentedTabs(
        key: key,
        items: values,
        selected: selected,
        onChanged: onChanged,
        labelBuilder: labelBuilder,
        extendedLabelBuilder: extendedLabelBuilder,
        iconBuilder: iconBuilder,
        fullWidth: fullWidth,
        backgroundColor: backgroundColor,
        activePillColor: activePillColor,
        activeTextColor: activeTextColor,
        inactiveTextColor: inactiveTextColor,
        activeIconColor: activeIconColor,
        borderRadius: borderRadius,
        padding: padding,
        border: border,
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;

    final resolvedBg = backgroundColor ?? theme.colorScheme.surfaceContainer;
    final resolvedPill = activePillColor ?? theme.colorScheme.surface;
    final resolvedActiveText = activeTextColor ?? theme.colorScheme.onSurface;
    final resolvedInactiveText = inactiveTextColor ?? theme.colorScheme.onSurfaceVariant;
    final resolvedActiveIcon = activeIconColor ?? theme.colorScheme.primary;
    final effectiveRadius = borderRadius ?? BorderRadius.circular(24);
    final effectivePillRadius = borderRadius != null
        ? borderRadius!.subtract(BorderRadius.circular(4))
        : BorderRadius.circular(20);

    Widget buildTabItem(T value) {
      final isSelected = selected == value;
      final displayLabel = isSelected && extendedLabelBuilder != null
          ? extendedLabelBuilder!(value)
          : labelBuilder(value);
      final itemIcon = iconBuilder != null ? iconBuilder!(value) : null;

      return Semantics(
        selected: isSelected,
        button: true,
        label: displayLabel,
        child: GestureDetector(
          onTap: () => onChanged(value),
          behavior: HitTestBehavior.opaque,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              horizontal: fullWidth ? 4 : 14,
              vertical: 8.5,
            ),
            decoration: BoxDecoration(
              color: isSelected ? resolvedPill : Colors.transparent,
              borderRadius: effectivePillRadius,
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: dark ? 0.32 : 0.07,
                        ),
                        blurRadius: 4,
                        offset: const Offset(0, 1.5),
                      ),
                    ]
                  : null,
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              transitionBuilder: (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
              child: Row(
                key: ValueKey('$value-$isSelected'),
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (itemIcon != null) ...[
                    Icon(
                      itemIcon,
                      size: 16,
                      color: isSelected ? resolvedActiveIcon : resolvedInactiveText,
                    ),
                    if (isSelected) const SizedBox(width: 5),
                  ],
                  if (itemIcon == null || isSelected)
                    Flexible(
                      child: Text(
                        displayLabel,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected ? resolvedActiveText : resolvedInactiveText,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final effectiveBorder = border ??
        (fullWidth || extendedLabelBuilder != null || iconBuilder != null
            ? Border.all(
                color: theme.colorScheme.outlineVariant.withValues(alpha: 0.6),
                width: 0.8,
              )
            : null);

    if (fullWidth || extendedLabelBuilder != null || iconBuilder != null) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: resolvedBg,
          borderRadius: effectiveRadius,
          border: effectiveBorder,
        ),
        padding: padding,
        child: Row(
          children: items.map((value) {
            final isSelected = selected == value;
            final flex = isSelected
                ? (iconBuilder != null ? 3 : 4)
                : (iconBuilder != null ? 1 : 2);
            return Expanded(flex: flex, child: buildTabItem(value));
          }).toList(),
        ),
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: resolvedBg,
        borderRadius: effectiveRadius,
        border: effectiveBorder,
      ),
      child: Padding(
        padding: padding,
        child: Wrap(
          spacing: 2,
          runSpacing: 2,
          children: items.map(buildTabItem).toList(),
        ),
      ),
    );
  }
}

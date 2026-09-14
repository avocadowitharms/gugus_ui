import 'package:flutter/material.dart';
import 'gugus_segmented_tabs.dart';

/// Pre-configured theme tabs selector for System, Light, and Dark modes.
///
/// Drop-in compatible with Flutter's standard [ThemeMode].
class PipThemeTabs extends StatelessWidget {
  /// The currently selected [ThemeMode].
  final ThemeMode selected;

  /// Callback when a theme is selected.
  final ValueChanged<ThemeMode> onChanged;

  /// Whether to display in full-width expansion mode.
  final bool fullWidth;

  /// Optional custom system label.
  final String systemLabel;

  /// Optional custom light label.
  final String lightLabel;

  /// Optional custom dark label.
  final String darkLabel;

  /// Optional custom background color.
  final Color? backgroundColor;

  /// Optional custom active pill color.
  final Color? activePillColor;

  /// Optional custom active icon color.
  final Color? activeIconColor;

  const PipThemeTabs({
    super.key,
    required this.selected,
    required this.onChanged,
    this.fullWidth = true,
    this.systemLabel = 'System',
    this.lightLabel = 'Light',
    this.darkLabel = 'Dark',
    this.backgroundColor,
    this.activePillColor,
    this.activeIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return PipSegmentedTabs<ThemeMode>(
      fullWidth: fullWidth,
      items: ThemeMode.values,
      selected: selected,
      backgroundColor: backgroundColor,
      activePillColor: activePillColor,
      activeIconColor: activeIconColor,
      labelBuilder: (mode) => switch (mode) {
        ThemeMode.system => systemLabel,
        ThemeMode.light => lightLabel,
        ThemeMode.dark => darkLabel,
      },
      iconBuilder: (mode) => switch (mode) {
        ThemeMode.system => Icons.brightness_auto_rounded,
        ThemeMode.light => Icons.light_mode_rounded,
        ThemeMode.dark => Icons.dark_mode_rounded,
      },
      onChanged: onChanged,
    );
  }
}

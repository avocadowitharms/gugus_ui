import 'package:flutter/material.dart';
import 'gugus_segmented_tabs.dart';

/// Pre-configured period & week selector tab control.
///
/// Supports flexible intervals such as 7 days (Week), 30 days (Month),
/// 90 days (Quarter), and 365 days (Year).
class PipWeekPeriodTabs extends StatelessWidget {
  /// The currently selected period in days (e.g. 7, 30, 90, 365).
  final int selectedDays;

  /// Callback when a period is selected.
  final ValueChanged<int> onChanged;

  /// List of period options in days. Defaults to `[7, 30, 90, 365]`.
  final List<int> periods;

  /// Custom label mapper (e.g. 7 -> '7D', 365 -> '1Y').
  final String Function(int days)? labelBuilder;

  /// Custom extended label mapper shown when active (e.g. 7 -> 'Week', 30 -> 'Month').
  final String Function(int days)? extendedLabelBuilder;

  /// Whether to display in full-width expansion mode.
  final bool fullWidth;

  /// Custom background color.
  final Color? backgroundColor;

  /// Custom active pill color.
  final Color? activePillColor;

  const PipWeekPeriodTabs({
    super.key,
    required this.selectedDays,
    required this.onChanged,
    this.periods = const [7, 30, 90, 365],
    this.labelBuilder,
    this.extendedLabelBuilder,
    this.fullWidth = true,
    this.backgroundColor,
    this.activePillColor,
  });

  @override
  Widget build(BuildContext context) {
    return PipSegmentedTabs<int>(
      fullWidth: fullWidth,
      items: periods,
      selected: selectedDays,
      backgroundColor: backgroundColor,
      activePillColor: activePillColor,
      labelBuilder: labelBuilder ??
          ((v) => switch (v) {
                7 => '7D',
                30 => '30D',
                90 => '90D',
                365 => '1Y',
                _ => '${v}D',
              }),
      extendedLabelBuilder: extendedLabelBuilder ??
          ((v) => switch (v) {
                7 => 'Week',
                30 => 'Month',
                90 => 'Quarter',
                365 => 'Year',
                _ => '${v} Days',
              }),
      onChanged: onChanged,
    );
  }
}

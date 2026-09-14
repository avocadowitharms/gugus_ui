import 'package:flutter/material.dart';
import 'pip_segmented_tabs.dart';

/// Supported default metric / download dimensions.
enum PipMetricDimension {
  downloads,
  users,
  revenue,
  rating,
}

/// Pre-configured tab control for switching between Downloads, Active Users,
/// Revenue, and Ratings or custom metrics.
class PipDownloadTabs extends StatelessWidget {
  /// Currently selected metric dimension.
  final PipMetricDimension selected;

  /// Callback when a metric is selected.
  final ValueChanged<PipMetricDimension> onChanged;

  /// List of metrics to show. Defaults to all [PipMetricDimension.values].
  final List<PipMetricDimension> metrics;

  /// Whether to display in full-width mode.
  final bool fullWidth;

  /// Custom background color.
  final Color? backgroundColor;

  /// Custom active pill color.
  final Color? activePillColor;

  /// Custom active icon color.
  final Color? activeIconColor;

  const PipDownloadTabs({
    super.key,
    required this.selected,
    required this.onChanged,
    this.metrics = PipMetricDimension.values,
    this.fullWidth = true,
    this.backgroundColor,
    this.activePillColor,
    this.activeIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return PipSegmentedTabs<PipMetricDimension>(
      fullWidth: fullWidth,
      items: metrics,
      selected: selected,
      backgroundColor: backgroundColor,
      activePillColor: activePillColor,
      activeIconColor: activeIconColor,
      labelBuilder: (m) => switch (m) {
        PipMetricDimension.downloads => 'Downloads',
        PipMetricDimension.users => 'Users',
        PipMetricDimension.revenue => 'Revenue',
        PipMetricDimension.rating => 'Rating',
      },
      iconBuilder: (m) => switch (m) {
        PipMetricDimension.downloads => Icons.download_rounded,
        PipMetricDimension.users => Icons.people_outline_rounded,
        PipMetricDimension.revenue => Icons.attach_money_rounded,
        PipMetricDimension.rating => Icons.star_outline_rounded,
      },
      onChanged: onChanged,
    );
  }
}

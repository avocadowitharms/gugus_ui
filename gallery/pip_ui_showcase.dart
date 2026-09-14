import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../navbar/pip_glass_navbar.dart';
import '../tabs/pip_segmented_tabs.dart';
import '../tabs/pip_theme_tabs.dart';
import '../tabs/pip_week_tabs.dart';
import '../tabs/pip_download_tabs.dart';
import '../buttons/pip_glass_button.dart';
import '../buttons/pip_buttons.dart';
import '../buttons/pip_trend_badge.dart';
import '../layout/pip_scaffold.dart';
import '../layout/pip_header.dart';

/// An interactive showcase gallery demonstrating all standalone Pip UI components.
///
/// Can be embedded into any Flutter app or run standalone.
class PipUiShowcase extends StatefulWidget {
  const PipUiShowcase({super.key});

  @override
  State<PipUiShowcase> createState() => _PipUiShowcaseState();
}

class _PipUiShowcaseState extends State<PipUiShowcase> {
  int _navIndex = 0;
  ThemeMode _selectedTheme = ThemeMode.system;
  int _selectedPeriod = 7;
  PipMetricDimension _selectedMetric = PipMetricDimension.downloads;
  String _selectedCustomTab = 'Charts';
  bool _buttonLoading = false;
  double _blurSigma = 30.0;
  int _clickCount = 0;

  final List<PipNavItem> _navItems = const [
    PipNavItem(
      label: 'Overview',
      icon: CupertinoIcons.chart_bar,
      selectedIcon: CupertinoIcons.chart_bar_alt_fill,
    ),
    PipNavItem(
      label: 'Reviews',
      icon: CupertinoIcons.chat_bubble_2,
      selectedIcon: CupertinoIcons.chat_bubble_2_fill,
      badge: '3',
    ),
    PipNavItem(
      label: 'Apps',
      icon: CupertinoIcons.square_grid_2x2,
      selectedIcon: CupertinoIcons.square_grid_2x2_fill,
    ),
    PipNavItem(
      label: 'Profile',
      icon: CupertinoIcons.person,
      selectedIcon: CupertinoIcons.person_fill,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PipScaffold(
      bottomNavigationBar: PipGlassNavBar(
        items: _navItems,
        currentIndex: _navIndex,
        blurSigma: _blurSigma,
        onTap: (index) {
          setState(() => _navIndex = index);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(milliseconds: 900),
              content: Text('Switched to ${_navItems[index].label} Tab'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
      ),
      child: PipPageLayout(
        children: [
          PipHeader(
            title: 'Pip UI Component Kit',
            subtitle: 'Standalone Frosted Glass UI for any Flutter App',
            showSettingsButton: true,
            onSettingsTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Header Glass Action tapped!'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),

          // 1. Navigation Bar Preview Card
          const PipSectionTitle(
            '1. Floating Glass Navbar',
            subtitle: 'Capsule bar with frosted blur, active pill, and badges',
          ),
          _buildCard(
            context,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Active Tab: ${_navItems[_navIndex].label} (Index: $_navIndex)',
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text('Blur Intensity: '),
                    Expanded(
                      child: Slider(
                        value: _blurSigma,
                        min: 5.0,
                        max: 50.0,
                        divisions: 9,
                        label: '${_blurSigma.toInt()} px',
                        onChanged: (val) => setState(() => _blurSigma = val),
                      ),
                    ),
                    Text('${_blurSigma.toInt()} px', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'The floating navbar is pinned below at the bottom of the screen with smooth backdrop filter blur.',
                  style: TextStyle(fontSize: 12.5, color: Colors.grey),
                ),
              ],
            ),
          ),

          // 2. Tabs: Theme, Week, Downloads
          const PipSectionTitle(
            '2. Segmented Tabs & Selectors',
            subtitle: 'Smooth sliding pills with icons, labels, and micro-animations',
          ),

          _buildCard(
            context,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Theme Tab
                const Text(
                  'A. Theme Mode Tabs (System / Light / Dark)',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5),
                ),
                const SizedBox(height: 10),
                PipThemeTabs(
                  selected: _selectedTheme,
                  onChanged: (mode) => setState(() => _selectedTheme = mode),
                ),
                const SizedBox(height: 20),

                // Week / Period Tab
                const Text(
                  'B. Week & Period Tabs (7D / 30D / 90D / 1Y)',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5),
                ),
                const SizedBox(height: 10),
                PipWeekPeriodTabs(
                  selectedDays: _selectedPeriod,
                  onChanged: (period) => setState(() => _selectedPeriod = period),
                ),
                const SizedBox(height: 20),

                // Downloads & Metric Tab
                const Text(
                  'C. Downloads & Metrics Tabs (Downloads / Users / Revenue / Rating)',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5),
                ),
                const SizedBox(height: 10),
                PipDownloadTabs(
                  selected: _selectedMetric,
                  onChanged: (metric) => setState(() => _selectedMetric = metric),
                ),
                const SizedBox(height: 20),

                // Generic custom tabs
                const Text(
                  'D. Custom Generic Tabs',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5),
                ),
                const SizedBox(height: 10),
                PipSegmentedTabs<String>(
                  items: const ['Charts', 'Analytics', 'Reports', 'Exports'],
                  selected: _selectedCustomTab,
                  labelBuilder: (item) => item,
                  onChanged: (tab) => setState(() => _selectedCustomTab = tab),
                ),
              ],
            ),
          ),

          // 3. Glass Buttons & Action Buttons
          const PipSectionTitle(
            '3. Glass & Action Buttons',
            subtitle: 'Tactile primary, glass, secondary, outline, and icon controls',
          ),
          _buildCard(
            context,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    PipActionButton(
                      label: 'Primary Action',
                      icon: Icons.check_circle_outline_rounded,
                      variant: PipButtonVariant.primary,
                      isLoading: _buttonLoading,
                      onPressed: () {
                        setState(() => _buttonLoading = true);
                        Future.delayed(
                          const Duration(seconds: 1),
                          () => setState(() => _buttonLoading = false),
                        );
                      },
                    ),
                    PipActionButton(
                      label: 'Glass Button',
                      variant: PipButtonVariant.glass,
                      icon: Icons.auto_awesome_rounded,
                      onPressed: () => setState(() => _clickCount++),
                    ),
                    PipActionButton(
                      label: 'Secondary',
                      variant: PipButtonVariant.secondary,
                      onPressed: () {},
                    ),
                    PipActionButton(
                      label: 'Outline',
                      variant: PipButtonVariant.outline,
                      onPressed: () {},
                    ),
                    PipActionButton(
                      label: 'Ghost',
                      variant: PipButtonVariant.ghost,
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    PipGlassIconButton(
                      tooltip: 'Settings',
                      iconData: Icons.settings_outlined,
                      onPressed: () {},
                    ),
                    const SizedBox(width: 12),
                    PipGlassIconButton(
                      tooltip: 'Refresh',
                      iconData: Icons.refresh_rounded,
                      onPressed: () {},
                    ),
                    const SizedBox(width: 12),
                    PipGlassIconButton(
                      tooltip: 'Menu',
                      icon: const PipMenuLinesIcon(),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Glass Clicks: $_clickCount',
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 4. Trend Badges
          const PipSectionTitle(
            '4. Metric Trend Badges',
            subtitle: 'Positive and negative percentage indicators',
          ),
          _buildCard(
            context,
            child: const Wrap(
              spacing: 12,
              runSpacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                PipTrendBadge(change: 24.8, showPlusSign: true),
                PipTrendBadge(change: 5.2),
                PipTrendBadge(change: -3.4),
                PipTrendBadge(change: -12.9),
                PipTrendBadge(change: -8.1, lowerIsBetter: true),
              ],
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, {required Widget child}) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.8),
          width: 0.8,
        ),
      ),
      child: child,
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gugus_ui/gugus_ui.dart';

void main() {
  group('Pip UI Kit Tests', () {
    testWidgets('PipGlassNavBar renders items and responds to taps', (tester) async {
      int selectedIndex = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: PipGlassNavBar(
              currentIndex: selectedIndex,
              onTap: (index) => selectedIndex = index,
              items: const [
                PipNavItem(
                  label: 'Overview',
                  icon: CupertinoIcons.chart_bar,
                  selectedIcon: CupertinoIcons.chart_bar_alt_fill,
                ),
                PipNavItem(
                  label: 'Reviews',
                  icon: CupertinoIcons.chat_bubble_2,
                  selectedIcon: CupertinoIcons.chat_bubble_2_fill,
                  badge: '5',
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(PipGlassNavBar), findsOneWidget);
      expect(find.text('5'), findsOneWidget);

      await tester.tap(find.byIcon(CupertinoIcons.chat_bubble_2));
      await tester.pumpAndSettle();

      expect(selectedIndex, 1);
    });

    testWidgets('PipThemeTabs switches between System, Light, and Dark modes', (tester) async {
      ThemeMode mode = ThemeMode.system;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) => PipThemeTabs(
                selected: mode,
                onChanged: (newMode) => setState(() => mode = newMode),
              ),
            ),
          ),
        ),
      );

      expect(find.text('System'), findsOneWidget);
      expect(find.byIcon(Icons.dark_mode_rounded), findsOneWidget);

      await tester.tap(find.byIcon(Icons.dark_mode_rounded));
      await tester.pumpAndSettle();

      expect(mode, ThemeMode.dark);
    });

    testWidgets('PipWeekPeriodTabs switches period intervals', (tester) async {
      int selected = 7;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) => PipWeekPeriodTabs(
                selectedDays: selected,
                onChanged: (newPeriod) => setState(() => selected = newPeriod),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Week'), findsOneWidget);
      expect(find.text('30D'), findsOneWidget);

      await tester.tap(find.text('30D'));
      await tester.pumpAndSettle();

      expect(selected, 30);
    });

    testWidgets('PipDownloadTabs switches between metric dimensions', (tester) async {
      PipMetricDimension dimension = PipMetricDimension.downloads;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) => PipDownloadTabs(
                selected: dimension,
                onChanged: (d) => setState(() => dimension = d),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Downloads'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.attach_money_rounded));
      await tester.pumpAndSettle();

      expect(dimension, PipMetricDimension.revenue);
    });

    testWidgets('PipFloatingGlassControl and Glass Icon Button render and tap', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PipGlassIconButton(
              iconData: Icons.settings,
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );

      expect(find.byType(PipFloatingGlassControl), findsOneWidget);
      await tester.tap(find.byIcon(Icons.settings));
      expect(tapped, isTrue);
    });

    testWidgets('PipActionButton renders all variants', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                PipActionButton(
                  label: 'Primary',
                  variant: PipButtonVariant.primary,
                  onPressed: () {},
                ),
                PipActionButton(
                  label: 'Glass',
                  variant: PipButtonVariant.glass,
                  onPressed: () {},
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
              ],
            ),
          ),
        ),
      );

      expect(find.text('Primary'), findsOneWidget);
      expect(find.text('Glass'), findsOneWidget);
      expect(find.text('Secondary'), findsOneWidget);
      expect(find.text('Outline'), findsOneWidget);
    });

    testWidgets('PipTrendBadge displays percentage and arrow icons', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                PipTrendBadge(change: 14.5, showPlusSign: true),
                PipTrendBadge(change: -6.2),
              ],
            ),
          ),
        ),
      );

      expect(find.text('+14.5%'), findsOneWidget);
      expect(find.text('6.2%'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_upward_rounded), findsOneWidget);
      expect(find.byIcon(Icons.arrow_downward_rounded), findsOneWidget);
    });

    testWidgets('PipUiShowcase renders cleanly without errors', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PipUiShowcase(),
        ),
      );

      expect(find.text('Pip UI Component Kit'), findsOneWidget);
      expect(find.byType(PipGlassNavBar), findsOneWidget);
      expect(find.text('5. Copyright & Creator Footer'), findsOneWidget);
    });

    testWidgets('GugusCopyright displays default heart icon, tagline, and creator text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GugusCopyright(),
          ),
        ),
      );

      expect(find.byIcon(CupertinoIcons.heart_fill), findsOneWidget);
      expect(find.text('Made with love'), findsOneWidget);
      expect(find.text('gugus. Software&Things © 2026'), findsOneWidget);
    });

    testWidgets('GugusCopyright supports custom parameters and hiding icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GugusCopyright(
              tagline: 'Designed in Switzerland',
              copyright: '© 2026 Custom Brand',
              showIcon: false,
            ),
          ),
        ),
      );

      expect(find.byIcon(CupertinoIcons.heart_fill), findsNothing);
      expect(find.text('Designed in Switzerland'), findsOneWidget);
      expect(find.text('© 2026 Custom Brand'), findsOneWidget);
    });

    testWidgets('GugusCopyright fixed mode with custom opacity applies Opacity widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GugusCopyright.fixed(
              opacity: 0.5,
              tagline: 'Fixed Footer',
            ),
          ),
        ),
      );

      final opacityFinder = find.byWidgetPredicate(
        (widget) => widget is Opacity && widget.opacity == 0.5,
      );
      expect(opacityFinder, findsOneWidget);
    });

    testWidgets('GugusCopyright revealed mode smoothly toggles animated opacity', (tester) async {
      bool isRevealed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) => GugusCopyright.revealed(
                isRevealed: isRevealed,
                opacity: 0.8,
                tagline: 'Revealed Footer',
              ),
            ),
          ),
        ),
      );

      // Initially hidden (opacity: 0.0)
      final initialAnimatedOpacity = tester.widget<AnimatedOpacity>(
        find.byType(AnimatedOpacity),
      );
      expect(initialAnimatedOpacity.opacity, 0.0);

      // Reveal footer
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GugusCopyright.revealed(
              isRevealed: true,
              opacity: 0.8,
              tagline: 'Revealed Footer',
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final revealedAnimatedOpacity = tester.widget<AnimatedOpacity>(
        find.byType(AnimatedOpacity),
      );
      expect(revealedAnimatedOpacity.opacity, 0.8);
    });

    testWidgets('PipCopyright alias renders identically', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PipCopyright(
              tagline: 'Pip Kit',
              copyright: 'All rights reserved',
            ),
          ),
        ),
      );

      expect(find.text('Pip Kit'), findsOneWidget);
      expect(find.text('All rights reserved'), findsOneWidget);
    });
  });
}

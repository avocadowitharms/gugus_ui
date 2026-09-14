import 'package:flutter/material.dart';

/// A glass-friendly scaffold that extends body under system bars and supports
/// floating glass navigation bars without clipping.
class PipScaffold extends StatelessWidget {
  final Widget child;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Color? backgroundColor;

  const PipScaffold({
    super.key,
    required this.child,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: backgroundColor,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        body: child,
      );
}

/// A scrollable content page wrapper with top & bottom smooth gradient dissolving
/// masks so floating navbars and headers float naturally above content.
class PipPageLayout extends StatelessWidget {
  final List<Widget> children;
  final Future<void> Function()? onRefresh;
  final EdgeInsetsGeometry? customPadding;
  final double maxWidth;
  final bool showTopGradient;
  final bool showBottomGradient;
  final ScrollPhysics? physics;
  final ScrollController? scrollController;

  const PipPageLayout({
    super.key,
    required this.children,
    this.onRefresh,
    this.customPadding,
    this.maxWidth = 640.0,
    this.showTopGradient = true,
    this.showBottomGradient = true,
    this.physics,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    final theme = Theme.of(context);
    final bg = theme.scaffoldBackgroundColor;

    final content = SingleChildScrollView(
      controller: scrollController,
      physics: physics ?? const AlwaysScrollableScrollPhysics(),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: customPadding ??
                  EdgeInsets.fromLTRB(
                    20,
                    topPadding + 16,
                    20,
                    bottomPadding + 110,
                  ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            ),
          ),
        ),
      ),
    );

    final scrollable = onRefresh == null
        ? content
        : RefreshIndicator(
            displacement: topPadding + 20,
            color: theme.colorScheme.primary,
            backgroundColor: theme.colorScheme.surface,
            onRefresh: onRefresh!,
            child: content,
          );

    return Stack(
      children: [
        scrollable,
        if (showTopGradient)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: topPadding + 12,
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      bg,
                      bg.withValues(alpha: 0.85),
                      bg.withValues(alpha: 0.0),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),
            ),
          ),
        if (showBottomGradient)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: bottomPadding + 48,
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      bg,
                      bg.withValues(alpha: 0.85),
                      bg.withValues(alpha: 0.0),
                    ],
                    stops: const [0.0, 0.45, 1.0],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

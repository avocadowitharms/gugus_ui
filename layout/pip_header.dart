import 'package:flutter/material.dart';
import '../buttons/pip_glass_button.dart';

/// Clean modern page header with a title, optional subtitle, and trailing action slot.
class PipHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? action;
  final VoidCallback? onSettingsTap;
  final bool showSettingsButton;

  const PipHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.action,
    this.onSettingsTap,
    this.showSettingsButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (title.isNotEmpty)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineLarge ??
                        const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.6,
                        ),
                  ),
                  if (subtitle != null && subtitle!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Text(
                        subtitle!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ) ??
                            const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                ],
              ),
            )
          else
            const Spacer(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (action != null) action!,
              if (action != null && (showSettingsButton || onSettingsTap != null))
                const SizedBox(width: 8),
              if (showSettingsButton || onSettingsTap != null)
                PipGlassIconButton(
                  tooltip: 'Settings',
                  onPressed: onSettingsTap,
                  icon: PipMenuLinesIcon(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Standard Pip section header with title and subtitle.
class PipSectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final EdgeInsetsGeometry padding;

  const PipSectionTitle(
    this.title, {
    super.key,
    this.subtitle = '',
    this.padding = const EdgeInsets.only(top: 32, bottom: 14),
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge ??
                  const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
            ),
            if (subtitle.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ) ??
                      const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
          ],
        ),
      );
}

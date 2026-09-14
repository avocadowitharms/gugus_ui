import 'package:flutter/material.dart';
import 'package:gugus_ui/gugus_ui.dart';

void main() {
  runApp(const GugusShowcaseApp());
}

class GugusShowcaseApp extends StatefulWidget {
  const GugusShowcaseApp({super.key});

  @override
  State<GugusShowcaseApp> createState() => _GugusShowcaseAppState();
}

class _GugusShowcaseAppState extends State<GugusShowcaseApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gugus UI Showcase',
      debugShowCheckedModeBanner: false,
      theme: GugusUiTheme.lightTheme(),
      darkTheme: GugusUiTheme.darkTheme(),
      themeMode: _themeMode,
      home: PipUiShowcase(
        initialThemeMode: _themeMode,
        onThemeModeChanged: (mode) => setState(() => _themeMode = mode),
      ),
    );
  }
}

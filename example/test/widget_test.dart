import 'package:flutter_test/flutter_test.dart';
import 'package:example/main.dart';
import 'package:gugus_ui/gugus_ui.dart';

void main() {
  testWidgets('Showcase app loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const GugusShowcaseApp());
    expect(find.byType(PipUiShowcase), findsOneWidget);
  });
}


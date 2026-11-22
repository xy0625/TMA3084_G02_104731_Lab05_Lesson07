import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:bottom_navigator_bar_lab/main.dart';

void main() {
  testWidgets('Bottom navigation displays four tabs', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => TabModel(),
        child: const MaterialApp(home: BottomNavLab()),
      ),
    );

    // Verify that all four tab labels are displayed.
    expect(find.text('Home'), findsWidgets);
    expect(find.text('Alarm'), findsOneWidget);
    expect(find.text('Business'), findsOneWidget);
    expect(find.text('School'), findsOneWidget);

    // Verify that Home is selected initially.
    expect(
      tester
          .widget<BottomNavigationBar>(find.byType(BottomNavigationBar))
          .currentIndex,
      0,
    );

    // Tap Alarm and verify that the selected tab changes.
    await tester.tap(find.text('Alarm'));
    await tester.pump();

    expect(
      tester
          .widget<BottomNavigationBar>(find.byType(BottomNavigationBar))
          .currentIndex,
      1,
    );
  });
}

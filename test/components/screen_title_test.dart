import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bofe/components/screen_title.dart';

void main() {
  testWidgets('ScreenTitle should display child', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ScreenTitle(title: 'Home', child: Text('Hello World!')),
      ),
    );

    expect(find.text('Hello World!'), findsOneWidget);
  });
}

// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:access_checkout_flutter_web_sdk_demo/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

void main() {
  setUp(() {
    WebViewPlatform.instance = AndroidWebViewPlatform();
  });

  testWidgets('App renders', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our title is rendered
    expect(find.text('Flutter Access Checkout Demo'), findsOneWidget);

    // Verify that our tabs are rendered
    expect(find.text('Web SDK'), findsOneWidget);

    await tester.pump();
  });

}

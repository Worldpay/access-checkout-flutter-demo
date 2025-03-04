import 'package:flutter/services.dart';

class AccessCheckoutFlutter {
  static const channel = MethodChannel('com.worldpay.flutter/accesscheckout');

  static Future<void> listenForValidationUpdates(Function(bool) onValidationUpdated) async {
    channel.setMethodCallHandler((call) async {
      if (call.method case "onValidationUpdated") {
        onValidationUpdated(call.arguments as bool);
      }
    });
  }

  static Future<void> generateSession(
      {required Function(Map<dynamic, dynamic>) onSuccess,
      required Function(String) onError}) async {
    channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case "onSessionGenerated":
          onSuccess(call.arguments);

        case "onSessionError":
          onError(call.arguments);
      }
    });

    await channel.invokeMethod<String>('generateSession');
  }
}

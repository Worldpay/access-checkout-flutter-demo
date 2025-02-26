import 'package:flutter/services.dart';

class AccessCheckoutFlutter {
  static const channel = MethodChannel('AccessCheckoutSDK');

  static Future<void> initialiseCardValidation({
    panId,
    expiryDateId,
    cvcId,
  }) async {
    var dataToPass = <String, String>{
      "baseUrl": "https://",
      "merchantId": "flutter-god",
      "panId": panId,
      "expiryDateId": expiryDateId,
      "cvcId": cvcId,
    };

    await channel.invokeMethod<String>('initialiseCardValidation', dataToPass);
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

        default:
          print("Unknown Event: ${call.method}");
      }
    });

    await channel.invokeMethod<String>('generateSession');
  }
}

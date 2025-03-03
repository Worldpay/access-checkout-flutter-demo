import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class AccessCheckoutNativeWidget extends StatelessWidget {
  final String checkoutId;
  final String baseUrl;
  final bool useCardValidation;

  const AccessCheckoutNativeWidget({
    super.key,
    required this.checkoutId,
    required this.baseUrl,
    required this.useCardValidation,
  });

  static const StandardMessageCodec _decoder = StandardMessageCodec();

  @override
  Widget build(BuildContext context) {
    const String viewType = "com.worldpay.flutter/accesscheckout";
    final Map<String, dynamic> creationParams = <String, dynamic>{
      "baseUrl": baseUrl,
      "checkoutId": checkoutId,
      "useCardValidation": useCardValidation
    };

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:

  return PlatformViewLink(
    viewType: viewType,
    surfaceFactory: (context, controller) {
      return AndroidViewSurface(
        controller: controller as AndroidViewController,
        gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
        hitTestBehavior: PlatformViewHitTestBehavior.opaque,
      );
    },
    onCreatePlatformView: (params) {
      return PlatformViewsService.initSurfaceAndroidView(
          id: params.id,
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: _decoder,
          onFocus: () {
            params.onFocusChanged(true);
          },
        )
        ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
        ..create();
    },
  );
      case TargetPlatform.iOS:
        return UiKitView(
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
        );
      default:
        throw UnsupportedError("Unsupported platform view");
    }
  }
}

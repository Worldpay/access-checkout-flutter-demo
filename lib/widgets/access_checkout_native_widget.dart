import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class AccessCheckoutNativeWidget extends StatelessWidget {
  final String checkoutId;
  final String baseUrl;

  const AccessCheckoutNativeWidget({
    super.key,
    required this.checkoutId,
    required this.baseUrl,
  });

  static const StandardMessageCodec _decoder = StandardMessageCodec();

  @override
  Widget build(BuildContext context) {
    const String viewType = "com.worldpay.plugins/accesscheckoutview";
    final Map<String, String> creationParams = <String, String>{
      "baseUrl": baseUrl,
      "checkoutId": checkoutId,
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
        throw new UnsupportedError("Unsupported platform view");
      default:
        throw new UnsupportedError("Unsupported platform view");
    }
  }

  //TODO: Receive events via method channel
  Map getParams(String nativeID,
      String? placeholder,) {
    final Map<String, dynamic> params = {
      "nativeID": nativeID,
    };

    if (placeholder != null) {
      params.putIfAbsent("placeholder", () => placeholder);
    }

    return params;
  }
}

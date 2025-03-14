import 'package:access_checkout_flutter_web_sdk_demo/widgets/access_checkout_web_widget.dart';
import 'package:flutter/material.dart';

class WebSdkPage extends StatelessWidget {
  const WebSdkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: AccessCheckoutWebWidget(
          iframeBaseUrl: "http://localhost:3000/form.html",
          checkoutId: "00000000-0000-0000-0000-000000000000"
      ),
    );
  }
}

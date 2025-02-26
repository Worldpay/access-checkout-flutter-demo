import 'package:access_checkout_flutter_demo/widgets/access_checkout.dart';
import 'package:flutter/material.dart';

class NativeSdkPage extends StatelessWidget {
  const NativeSdkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: AccessCheckoutWidget(
            // TODO: Replace the checkout id and base url with the values provided to you
            checkoutId: "00000000-0000-0000-0000-000000000000",
            baseUrl: "https://try.access.worldpay.com"));
  }
}

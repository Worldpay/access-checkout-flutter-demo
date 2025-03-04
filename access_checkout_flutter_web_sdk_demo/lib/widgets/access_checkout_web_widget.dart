import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AccessCheckoutWebWidget extends StatefulWidget {
  final String iframeBaseUrl;
  final String checkoutId;

  const AccessCheckoutWebWidget({
    super.key,
    required this.iframeBaseUrl,
    required this.checkoutId,
  });

  @override
  State<AccessCheckoutWebWidget> createState() => _WebViewState();
}

class _WebViewState extends State<AccessCheckoutWebWidget> {
  late WebViewController controller;
  late String checkoutId;
  late String iframeBaseUrl;
  String sessionToken = "";

  @override
  void initState() {
    super.initState();
    checkoutId = widget.checkoutId;
    iframeBaseUrl = widget.iframeBaseUrl;

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'flutterWebView',
        onMessageReceived: (dynamic message) {
          setState(() {
            sessionToken = message.message;
          });
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {
            print(error.response);
          },
          onWebResourceError: (WebResourceError error) {
            print(error.description);
          },
        ),
      )
      ..loadRequest(
        Uri.parse("$iframeBaseUrl?checkoutId=$checkoutId"),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: 400,
                    height: 450,
                    child: WebViewWidget(controller: controller)
                ),
                if (sessionToken != "") Text(sessionToken),
              ],
            )));
  }
}

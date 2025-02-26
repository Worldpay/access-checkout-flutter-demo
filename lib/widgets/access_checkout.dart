import 'package:access_checkout_flutter_demo/service/access_checkout_flutter.dart';
import 'package:access_checkout_flutter_demo/widgets/access_checkout_native_widget.dart';
import 'package:flutter/material.dart';

class AccessCheckoutWidget extends StatefulWidget {
  final String checkoutId;
  final String baseUrl;

  const AccessCheckoutWidget({
    super.key,
    required this.checkoutId,
    required this.baseUrl,
  });

  @override
  AccessCheckoutWidgetState createState() => AccessCheckoutWidgetState();
}

class AccessCheckoutWidgetState extends State<AccessCheckoutWidget> {
  bool isInitialized = false;
  String sessionToken = "";
  late String checkoutId;
  late String baseUrl;

  @override
  void initState() {
    super.initState();
    checkoutId = widget.checkoutId;
    baseUrl = widget.baseUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 350,
                  height: 150,
                  child: AccessCheckoutNativeWidget(
                      checkoutId: checkoutId, baseUrl: baseUrl), //Container),
                ),
                Row(children: <Widget>[
                  Expanded(
                      child: ElevatedButton(
                        child: const Text('Submit'),
                        onPressed: () async {
                          await generateSession();
                        },
                      ))
                ]),
                if (sessionToken != "") Text(sessionToken),
              ],
            )));
  }

  Future<void> generateSession() async {
    await AccessCheckoutFlutter.generateSession(onSuccess: (sessions) {
      setState(() {
        sessionToken = sessions["CARD"]!;
      });
      showSnackBar(sessions["CARD"]!);
    }, onError: (error) {
      showSnackBar(error);
    });
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), duration: const Duration(seconds: 5)));
  }
}

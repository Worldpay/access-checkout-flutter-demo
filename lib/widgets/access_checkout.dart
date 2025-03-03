import 'package:access_checkout_flutter_demo/service/access_checkout_flutter.dart';
import 'package:access_checkout_flutter_demo/widgets/access_checkout_native_widget.dart';
import 'package:flutter/material.dart';

class AccessCheckoutWidget extends StatefulWidget {
  final String checkoutId;
  final String baseUrl;
  final bool useCardValidation;

  const AccessCheckoutWidget({
    super.key,
    required this.checkoutId,
    required this.baseUrl,
    required this.useCardValidation,
  });

  @override
  AccessCheckoutWidgetState createState() => AccessCheckoutWidgetState();
}

class AccessCheckoutWidgetState extends State<AccessCheckoutWidget> {
  bool isSubmitButtonEnabled = false;
  String sessionToken = "";
  late String checkoutId;
  late String baseUrl;
  late bool useCardValidation;

  @override
  void initState() {
    super.initState();
    checkoutId = widget.checkoutId;
    baseUrl = widget.baseUrl;
    useCardValidation = widget.useCardValidation;

    if (useCardValidation) {
      AccessCheckoutFlutter.listenForValidationUpdates((isInputValid) {
        setState(() {
          isSubmitButtonEnabled = isInputValid;
        });
      });
    } else {
      setState(() {
        isSubmitButtonEnabled = true;
      });
    }
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
                    height: 150,
                    child: AccessCheckoutNativeWidget(
                        checkoutId: checkoutId,
                        baseUrl: baseUrl,
                        useCardValidation: useCardValidation)),
                Row(children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: isSubmitButtonEnabled
                          ? () => generateSession()
                          : null,
                      child: const Text('Submit'),
                    ),
                  )
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

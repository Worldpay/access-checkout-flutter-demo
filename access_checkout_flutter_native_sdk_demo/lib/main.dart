import 'package:access_checkout_flutter_native_sdk_demo/screens/native_sdk_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Access Checkout Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Access Checkout Demo'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.mobile_friendly), text: "Native SDK"),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[NativeSdkPage()],
        ),
      ),
    );
  }
}

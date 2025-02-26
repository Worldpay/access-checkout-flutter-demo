package com.example.access_checkout_flutter_demo

import AccessCheckoutViewFactory
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    private val METHOD_CHANNEL_NAME = "AccessCheckoutSDK"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val registry = flutterEngine
            .platformViewsController
            .registry

        registry
            .registerViewFactory(
                "com.worldpay.plugins/accesscheckoutview",
                AccessCheckoutViewFactory(
                    flutterEngine.dartExecutor.binaryMessenger,
                    METHOD_CHANNEL_NAME,
                    this
                )
            )
    }

}
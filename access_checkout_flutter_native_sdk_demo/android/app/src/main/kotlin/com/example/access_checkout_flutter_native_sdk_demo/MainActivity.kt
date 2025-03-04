package com.example.access_checkout_flutter_native_sdk_demo

import com.example.access_checkout_flutter_native_sdk_demo.AccessCheckoutViewFactory
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    private val METHOD_CHANNEL_NAME = "com.worldpay.flutter/accesscheckout"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val registry = flutterEngine
            .platformViewsController
            .registry

        registry
            .registerViewFactory(
                "com.worldpay.flutter/accesscheckout",
                AccessCheckoutViewFactory(
                    flutterEngine.dartExecutor.binaryMessenger,
                    METHOD_CHANNEL_NAME,
                    this
                )
            )
    }
}

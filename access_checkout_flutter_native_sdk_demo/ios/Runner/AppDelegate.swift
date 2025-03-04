import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    private var METHOD_CHANNEL_NAME = "com.worldpay.flutter/accesscheckout"

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)

        weak var pluginRegistrar = registrar(forPlugin: "com.worldpay.flutter/accesscheckout")
        
        let factory = AccessCheckoutViewFactory(
            messenger: pluginRegistrar!.messenger(),
            channel: METHOD_CHANNEL_NAME)
        
        pluginRegistrar!.register(
            factory,
            withId: "com.worldpay.flutter/accesscheckout"
    
        )
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

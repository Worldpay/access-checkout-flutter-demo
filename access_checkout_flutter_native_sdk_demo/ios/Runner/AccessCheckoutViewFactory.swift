import Flutter
import UIKit

class AccessCheckoutViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger
    private var channel: String 

    init(messenger: FlutterBinaryMessenger, channel: String) {
        self.messenger = messenger
        self.channel = channel
        super.init()
    }

    
    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        let creationParams = args as? [String: Any] ?? [:]
        return AccessCheckoutView(
            methodChannel: FlutterMethodChannel(name: channel, binaryMessenger: messenger),
            frame: frame,
            viewIdentifier: viewId,
            binaryMessenger: messenger,
            creationParams: creationParams
        )
    }
    
    /// Implementing this method is only necessary when the `arguments` in `createWithFrame` is not `nil`.
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

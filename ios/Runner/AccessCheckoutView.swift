import AccessCheckoutSDK
import Flutter
import UIKit

class AccessCheckoutView: NSObject, FlutterPlatformView {
    @IBOutlet private var panInput: AccessCheckoutUITextField!
    @IBOutlet private var expiryInput: AccessCheckoutUITextField!
    @IBOutlet private var cvcInput: AccessCheckoutUITextField!
    private var accessCheckoutClient: AccessCheckoutClient
    private var methodChannel: FlutterMethodChannel
    private var _view: UIView

    private var baseUrl: String
    private var checkoutId: String
    private var useCardValidation: Bool
    
    private var controller: AccessCheckoutViewController


    init(
        methodChannel channel: FlutterMethodChannel,
        frame: CGRect,
        viewIdentifier viewId: Int64,
        binaryMessenger messenger: FlutterBinaryMessenger?,
        creationParams: [String: Any]
    ) {
        baseUrl = creationParams["baseUrl"] as? String ?? ""
        checkoutId = creationParams["checkoutId"] as? String ?? ""
        useCardValidation = creationParams["useCardValidation"] as? Bool ?? false
        methodChannel = channel

        accessCheckoutClient = try! AccessCheckoutClientBuilder()
            .accessBaseUrl(baseUrl)
            .checkoutId(checkoutId)
            .build()
        
        let storyboard = UIStoryboard(name: "AccessCheckoutView", bundle: Bundle.main)
        controller = storyboard.instantiateViewController(withIdentifier:"ViewController") as! AccessCheckoutViewController
     
        _view = controller.view!
      
        super.init()

        methodChannel.setMethodCallHandler({
            [weak self] (call, result) in
            guard let self = self else {return}

            switch call.method{
            case "generateSession":
                generateSession()
            default:
                result(FlutterMethodNotImplemented)

            }
        })

        // iOS views can be created here
        referenceNativeView()

        if(useCardValidation){
            initializeCardValidation()
        }
    }

    func initializeCardValidation() {
        let validationConfig = try! CardValidationConfig.builder()
            .pan(panInput)
            .expiryDate(expiryInput)
            .cvc(cvcInput)
            .accessBaseUrl(baseUrl)
            .validationDelegate(self)
            .enablePanFormatting()
                .build()


        AccessCheckoutValidationInitialiser().initialise(validationConfig)
    }

    func updateUIField(field: AccessCheckoutUITextField, isValid: Bool) {
        var  colour = isValid ? UIColor.green : UIColor.red

        //Update Text & border colour
        field.textColor = colour
        field.borderColor = colour
    }

    func generateSession() {

        let cardDetails = try! CardDetailsBuilder().pan(panInput)
            .expiryDate(expiryInput)
            .cvc(cvcInput)
            .build()

        do { try accessCheckoutClient.generateSessions(
            cardDetails: cardDetails,
            sessionTypes: [SessionType.card]) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                        self.methodChannel.invokeMethod("onSessionError", arguments: "Could not create session")

                    case .success(let sessions):
                        let sessionData = sessions.mapValues{$0}
                        self.methodChannel.invokeMethod("onSessionGenerated", arguments: sessionData)
                    }
                }
            }
        }
        catch {
            self.methodChannel.invokeMethod("onSessionError", arguments: "Could not create session")
        }
    }

    func referenceNativeView() {
        panInput = controller.panInput
        expiryInput = controller.expiryInput
        cvcInput = controller.cvcInput
    }


    func view() -> UIView {
        return _view
    }

}

extension AccessCheckoutView: AccessCheckoutCardValidationDelegate {
    func cardBrandChanged(cardBrand: AccessCheckoutSDK.CardBrand?) {
        //TODO
    }

    func panValidChanged(isValid: Bool) {
        self.updateUIField(field: self.panInput, isValid: isValid)
        if(!isValid){
            self.methodChannel.invokeMethod("OnValidationUpdated", arguments:false)
        }
    }

    func expiryDateValidChanged(isValid: Bool) {
        self.updateUIField(field: self.expiryInput, isValid: isValid)
        if(!isValid){
            self.methodChannel.invokeMethod("OnValidationUpdated", arguments:false)
        }
    }

    func cvcValidChanged(isValid: Bool) {
        self.updateUIField(field: self.cvcInput, isValid: isValid)
        if(!isValid){
            self.methodChannel.invokeMethod("OnValidationUpdated", arguments:false)
        }
    }

    func validationSuccess() {
        self.methodChannel.invokeMethod("OnValidationUpdated", arguments:true)

    }

}

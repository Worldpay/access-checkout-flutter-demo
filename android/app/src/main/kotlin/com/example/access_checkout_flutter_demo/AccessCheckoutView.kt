package com.example.access_checkout_flutter_demo

import android.content.Context
import android.graphics.Color
import android.graphics.drawable.GradientDrawable
import android.view.LayoutInflater
import android.view.View
import androidx.lifecycle.LifecycleOwner
import com.worldpay.access.checkout.client.api.exception.AccessCheckoutException
import com.worldpay.access.checkout.client.session.AccessCheckoutClient
import com.worldpay.access.checkout.client.session.AccessCheckoutClientBuilder
import com.worldpay.access.checkout.client.session.listener.SessionResponseListener
import com.worldpay.access.checkout.client.session.model.CardDetails
import com.worldpay.access.checkout.client.session.model.SessionType
import com.worldpay.access.checkout.client.validation.AccessCheckoutValidationInitialiser
import com.worldpay.access.checkout.client.validation.config.CardValidationConfig
import com.worldpay.access.checkout.client.validation.listener.AccessCheckoutCardValidationListener
import com.worldpay.access.checkout.client.validation.model.CardBrand
import com.worldpay.access.checkout.ui.AccessCheckoutEditText
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView


class AccessCheckoutView(
    private val lifecycleOwner: LifecycleOwner,
    private val methodChannel: MethodChannel,
    context: Context,
    creationParams: Map<String, Any>,
) :
    PlatformView {
    private val layout: View
    private val panInput: AccessCheckoutEditText
    private val expiryInput: AccessCheckoutEditText
    private val cvcInput: AccessCheckoutEditText

    private var baseUrl: String = creationParams["baseUrl"] as String
    private var checkoutId: String = creationParams["checkoutId"] as String
    private var useCardValidation: Boolean =
        creationParams["useCardValidation"] as? Boolean ?: false

    private var accessCheckoutClient: AccessCheckoutClient

    init {
        layout = LayoutInflater.from(context)
            .inflate(R.layout.access_checkout_layout, null)

        panInput = layout.findViewById(R.id.pan_input)
        expiryInput = layout.findViewById(R.id.expiry_date_input)
        cvcInput = layout.findViewById(R.id.cvc_input)

        if (useCardValidation) {
            initializeCardValidation()
        }
        accessCheckoutClient = AccessCheckoutClientBuilder()
            .baseUrl(baseUrl)
            .checkoutId(checkoutId)
            .lifecycleOwner(lifecycleOwner)
            .sessionResponseListener(
                object : SessionResponseListener {
                    override fun onError(error: AccessCheckoutException) {
                        methodChannel.invokeMethod("onSessionError", "Could not create session")
                    }

                    override fun onSuccess(sessionResponseMap: Map<SessionType, String>) {
                        // Important: Flutter will not understand SessionType
                        // therefore it needs to be converted into a JSON-serializable format
                        val sessionData = sessionResponseMap.mapKeys { it.key.name }
                        methodChannel.invokeMethod("onSessionGenerated", sessionData)
                    }
                }
            )
            .context(context)
            .build()

        methodChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                "generateSession" -> generateSession()
                else -> result.notImplemented()
            }
        }
    }

    //    private fun styleComponent() {}
    private fun initializeCardValidation() {
        val cardValidationConfig = CardValidationConfig.Builder()
            .baseUrl(baseUrl)
            .pan(panInput)
            .expiryDate(expiryInput)
            .cvc(cvcInput)
            .lifecycleOwner(lifecycleOwner)
            .enablePanFormatting()
            .validationListener(object : AccessCheckoutCardValidationListener {
                override fun onBrandChange(cardBrand: CardBrand?) {
                    // TODO: Update the brand image using your SVG loader
                }

                override fun onCvcValidated(isValid: Boolean) {
                    updateUIField(cvcInput, isValid)
                    if (!isValid) {
                        methodChannel.invokeMethod("onValidationUpdated", false)
                    }
                }

                override fun onExpiryDateValidated(isValid: Boolean) {
                    updateUIField(expiryInput, isValid)
                    if (!isValid) {
                        methodChannel.invokeMethod("onValidationUpdated", false)
                    }
                }

                override fun onPanValidated(isValid: Boolean) {
                    updateUIField(panInput, isValid)
                    if (!isValid) {
                        methodChannel.invokeMethod("onValidationUpdated", false)
                    }

                }

                override fun onValidationSuccess() {
                    methodChannel.invokeMethod("onValidationUpdated", true)
                }

            })
            .build()

        AccessCheckoutValidationInitialiser.initialise(cardValidationConfig)
    }

    private fun updateUIField(field: AccessCheckoutEditText, isValid: Boolean) {
        val colour = if (isValid) Color.GREEN else Color.RED

        //Update Text colour
        field.setTextColor(colour)
        //Update Border
        val border = GradientDrawable()
        border.setStroke(3, colour)
        field.background = border
    }


    private fun generateSession() {

        val cardDetails = CardDetails.Builder()
            .pan(panInput)
            .expiryDate(expiryInput)
            .cvc(cvcInput)
            .build()


        accessCheckoutClient.generateSessions(cardDetails, listOf(SessionType.CARD))
    }

    override fun getView(): View = layout
    override fun dispose() {}
}

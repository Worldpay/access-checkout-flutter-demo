import android.content.Context
import androidx.lifecycle.LifecycleOwner
import com.example.access_checkout_flutter_demo.AccessCheckoutView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class AccessCheckoutViewFactory(
    private val messenger: BinaryMessenger,
    private val channel: String,
    private val lifecycleOwner: LifecycleOwner
) :
    PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val methodChannel = MethodChannel(messenger, channel)
        val creationParams: Map<String, Any> = args as Map<String, Any>
        return AccessCheckoutView(lifecycleOwner, methodChannel, context, creationParams)
    }
}

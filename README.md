# Access Checkout Flutter Application Demo

This project leverages the Access Worldpay android and Access Worldpay iOS Native SDKs, to provide a way of integrating
Worldpay Access Checkout into a Flutter application using Native views PlatformView for Android and UIKit for iOS.

*_As Worldpay and Flutter evolve things may have changed so please refer to_ [_Worldpay Access
Checkout_](https://developer.worldpay.com/products/access/checkout) and  [_Flutter_](https://flutter.dev/docs)_,
for any questions or clarifications._*

## Getting Started

## Preparing your local environment

*_First install or upgrade to the latest version of Flutter. Follow these installation_ [
_guides_ ](https://flutter.dev/docs/get-started/install)*

For this Demo, it is recommended to use Android Studio as you code editor, which can be
downloaded [here](https://developer.android.com/studio/).
To complete the iOS deployment steps you will also need to have [Xcode](https://developer.apple.com/xcode/) installed.

You will also need set up:

- an [iOS simulator](https://flutter.dev/docs/get-started/install/macos#set-up-the-ios-simulator) as well as
- an [Android emulator](https://flutter.dev/docs/get-started/install/macos#set-up-the-android-emulator).

## Preparing your local environment Using `fvm`

We also recommended to use the [_fvm - flutter version
manager_](https://fvm.app/documentation/getting-started/installation) to ensure compatible and consistent builds of this
project.

To do this *_First install or upgrade to the latest fvm. Follow these installation_ [
_instructions_ ](https://fvm.app/documentation/getting-started/installation)*

## Changing the Checkout ID used by the application

In order to configure the application to use your test credentials.
Change the Checkout ID in the `lib/screens/native_sdk_page.dart` and/or `lib/screens/web_sdk_page.dart` files.
To the credentials provided to you.

## Changing the URL of Access Checkout used by the application

- for native integration, change the baseUrl in `lib/screens/native_sdk_page.dart`.
- for web integration, change the script url in `iframe-content/form.html`.

## Running the application

### Start the node server that serves the Web SDK integration HTML content

```bash
cd iframe-content
npm install
node server.js
```

### Running on Android

#### 1. Running The emulator

Start an android emulator with a `minSdkVersion` of `26`

#### 2. Preparing the Web SDK view

Change in the `web_sdk_page.dart` file:

- the iframeBaseUrl to `http://localhost:3000/form.html` so that the Web integration works correctly
- refer to the `Changing the Checkout ID used by the application` section of this readme and change the checkoutId to a
  valid checkoutID

#### 3. Running the application

#### Using flutter
```shell
flutter run
```

#### Using fvm
```shell
fvm flutter run
```

### Running on iOS

#### 1. Running The simulator

Start an ios simulator

#### 2. Preparing the Web SDK view

Change in the `web_sdk_page.dart` file:

- the iframeBaseUrl to `http://10.0.2.2:3000/form.html` so that the Web integration works correctly
- refer to the `Changing the Checkout ID used by the application` section of this readme and change the checkoutId to a
  valid checkoutID

#### 3. Running the application
#### Using flutter
```shell
flutter run
```

### Using fvm
```shell
fvm flutter run
```

### Notes on the creation of the Podfile for iOS

The `flutter create` command does not generate any `Podfile`.
That file is needed and requires specific code for the `webview_flutter` package to be able to source the `webview_flutter_wkwebview` dependency.

To create it for a brand new application:
1. Run `flutter run` and choose an iOS destination
2. You will see an error displayed in the terminal as no iOS development team is selected by default in the iOS project config
3. Instructions in the terminal explain how to resolve it (you essentially need to select an Apple team so XCode can sign the app)
4. Add any other dependencies in the `Podfile`, such as the AccessCheckoutSDK

DO NOT first create manually the `Podfile` file and expect `flutter run` to add the additional code, that won't work.

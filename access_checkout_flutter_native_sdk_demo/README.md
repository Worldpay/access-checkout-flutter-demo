# Access Checkout Flutter Application Demo using Native SDKs

This project leverages the Access Worldpay Android and Access Worldpay iOS Native SDKs, to provide a way of integrating
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

## Configuring your credentials

#### Changing the URL of Access Checkout used by the application

- Change the baseUrl in `lib/screens/native_sdk_page.dart`.

#### Changing the Checkout ID used by the application

- In order to configure the application to use your test credentials.
Change the Checkout ID in the `lib/screens/native_sdk_page.dart`.
To the credentials provided to you.

## Running the application

### Running on Android

#### 1. Running The emulator

Start an android emulator with a `minSdkVersion` of `26`

#### 2. Running the application

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

#### 2. Preparing the application

```shell
# Install Cocoapods pod dependencies
cd ios
pod install
```


#### 3. Running the application

#### Using flutter

```shell
flutter run
```

### Using fvm

```shell
fvm flutter run
```

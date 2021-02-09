# Student Beans Connect iOS SDK

Library for integrating Student Beans Connect in iOS.

<div align="center">
    <img src="/Screenshots/Screen 01.png" alt="Screenshot 1" width="200"/>
    <img src="/Screenshots/Screen 02.png" alt="Screenshot 2" width="200"/>
    <img src="/Screenshots/Screen 03.png" alt="Screenshot 3" width="200"/>
    <img src="/Screenshots/Screen 04.png" alt="Screenshot 4" width="200"/>
</div>

## Installation

### Requirements

Languages: Swift.

Minimum iOS version: 11.0.

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website.

To integrate the SDK into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
target '<Your Target Name>' do
    pod 'SBConnect', :git => 'https://github.com/student-beans/iOS-InAppConnect.git'
end
```

Then, run the following command in the terminal from your project directory:

```bash
$ pod install
```

### Manual

Download `SBConnect.xcframework` from the top level of this repository. Drag the framework in to your project directory:

<img src="/Screenshots/File Structure.png" alt="File Structure" width="200"/>


Ensure that “Copy items if needed” is checked when choosing options for adding the framework.

<img src="/Screenshots/Copy Items If Needed.png" alt="Copy Items If Needed" width="300"/>


Make sure to select “Embed & Sign” in Target Settings > General.

<img src="/Screenshots/Embed And Sign.png" alt="Embed And Sign" width="400"/>

## Usage

Please refer to the demo app within the SBConnectDemo folder as an example of how to integrate this library into your own app.

Firstly, `SBConnect` is added using the import statement:


```swift
import SBConnect
```

We provide a protocol `SBConnectProtocol` for the `SBConnect` class, which you can use to mock SBConnect for unit testing purposes:


```swift
var sbConnect: SBConnectProtocol.Type = SBConnect.self
```

If you don't want to use the protocol, you can use the `SBConnect` class directly. To do this, omit the above line and replace uses of `sbConnect` with `SBConnect`.

`SBConnect` has only one method; `connect(slug:countryCode:completion:)`. Call this method to show the user the SBConnect view, which allows your student users to log in to Student Beans and collect their discount code. Pass your offer slug, country code, and a completion handler for responding to the various routes the user could take:

```swift
sbConnect.connect(slug:"<your-unique-sb-offer-slug>", countryCode: "<uk>") { [weak self] response in
    self?.handleSBConnectResponse(response)
}
```

Upon calling this method, the SBConnect view will be displayed and will handle all user interaction within the view.
It's important you liaise with your Student Beans account manager to confirm your slug and country code and pass these correctly, otherwise you will be returned an error and the SBConnect view will close.

The completion handler passed to `connect(slug:countryCode:completion:)` returns a single parameter of `SBConnectResponse` type:

```swift
public enum SBConnectResponse: Equatable {
    case success(_ discountCode: String?)
    case failure(_ error: SBConnectError)
    case closed
}
```

You should handle the `SBConnectResponse` using a `switch` statement, for example:

```swift
private func handleSBConnectResponse(_ response: SBConnectResponse) {
    switch response {
    case .success(let discountCode):
        // Apply discount at checkout
    case .failure(let error):
        // Handle the error
    case .closed:
        // Prompt user
    }
}
```

The `success` case is returned when your student user has completed their authentication with Student Beans and retrieved their discount code. It is now copied to their clipboard, and passed as an optional `String` so you can choose to perform your own actions such as automatically applying the discount code to their basket.

The `closed` case is returned when the user manually closes the SBConnect view. You may wish to show the user a prompt, or perform tracking actions here.

The `failure` case is returned when an error occurs during the lifetime of the SBConnect view. An `SBConnectError` is passed with the following cases:

```swift
public enum SBConnectError: LocalizedError, Equatable {
    case invalidParameters
    case pageNotFound(_ errorDescription: String?)
    case codeIssuance(_ errorDescription: String?)
    case general(_ errorDescription: String?)
}
```

An `invalidParameters` error occurs when either the `slug` or `countryCode` passed to `connect(slug:countryCode:completion:)` is empty. You must provide a valid `slug` and `countryCode` in order to find your offer.

A `pageNotFound` error occurs when your offer cannot be found by SBConnect. This could be due to a typo in your `slug` or `countryCode`. This can also occur when your offer is not yet live, or expired. If you have checked your `slug` and `countryCode` are correct and still receive this error, please contact your Student Beans account manager.

A `codeIssuance` error occurs when we have run out of unique discount codes for your offer or your offer has expired. These are rare and will usually be quickly resolved by your account manager at Student Beans. If you experience these errors often, or for a prolonged period of time, please contact your Student Beans account manager.

A `general` error is a catch-all error that can occur for a number of reasons such as network errors and server errors. As above, if you experience these errors often, or for a prolonged period of time, please contact your Student Beans account manager.


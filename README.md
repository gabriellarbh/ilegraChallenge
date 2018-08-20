# README
The goal of this project is to develop an app using Marvel’s comic books characters API, with the data being provided by Marvel itself. The API’s documentation and tutorials are available in [Marvel Developer Portal](http://developer.marvel.com).


## Technologies
The frameworks used in this project are:
* [UIKit | Apple Developer Documentation](https://developer.apple.com/documentation/uikit)
* [Foundation | Apple Developer Documentation](https://developer.apple.com/documentation/foundation)
* [CFNetwork | Apple Developer Documentation](https://developer.apple.com/documentation/cfnetwork)
* [Differentiator on CocoaPods.org](https://cocoapods.org/pods/Differentiator)
* [RxSwift/RxCocoa at master · ReactiveX/RxSwift · GitHub](https://github.com/ReactiveX/RxSwift/tree/master/RxCocoa)
* [GitHub - ReactiveX/RxSwift: Reactive Programming in Swift](https://github.com/ReactiveX/RxSwift)
* [GitHub - onevcat/Kingfisher](https://github.com/onevcat/Kingfisher)
* [GitHub - RxSwiftCommunity/RxDataSources](https://github.com/RxSwiftCommunity/RxDataSources)
* [GitHub - RxSwiftCommunity/RxOptional: RxSwift extensions for Swift optionals and “Occupiable" types](https://github.com/RxSwiftCommunity/RxOptional)
* [GitHub - IdleHandsApps/UINavigationBar-Transparent](https://github.com/IdleHandsApps/UINavigationBar-Transparent)

## Installing
To use this application, you need to have
* [Xcode - Apple Developer](https://developer.apple.com/xcode/)
* [CocoaPods.org](https://cocoapods.org)
* Terminal

After cloning the repository, open Terminal in the ilegraChallenge folder and run `pod install` to install the necessary pods to the project.

### [IMPORTANT] Private and public keys
The Marvel API requests for authentication, when you sign up in the developer portal you get two keys, a private key and a public key.

To request the data, you must create a plist file with two keys: _publicKey_ and _privateKey_, with its respective values **inside the project root folder**. Otherwise, it won’t be possible to get any character data (boo :( ).

### Running
After installing, open ::IlegraChallenge.xcworkspace:: and press ⌘B to build and ⌘R to run the project.


## Testing 
To run tests, open  ::IlegraChallenge.xcworkspace:: and press ⌘U to run all the tests.

### Code Coverage
If you want to check the code coverage, go to your Schemes - located right beside the Run and Stop buttons in the IDE - and select Edit Scheme. In the Test menu, go to Options and check the Gather Coverage checkbox.

The code coverage for this project is **76%**. 

##  Future Work
* Research asynchronous testing using RxTests.
* Implement tests using the library.
* Download comic book metadata and make it available to users.



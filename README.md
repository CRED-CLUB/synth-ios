# synth
A framework designed over neumorphic style. Provides an extension over UIKit elements `UIView` and `UIButton`.

## Installation
It can be easily integrated with Cocoapods. Add this line to your podfile:
```swift
pod 'NeumorphicKit'
```

## Requirements
- iOS 11.0+
- Swift 5.0+

## Usage
As it provides an extension over `UIView`, you can call it over any UI element
```swift
import NeumorphicKit

let neumorphicView = UIView()
neumorphicView.applyNeuStyle()
```
`applyNeuStyle` configures view with default configuration. This function takes two arguments, which lets you configure with your own custom model. `NeuViewModel` has a list of properties to change baseColor, shadow models, light direction, etc.

There are three styles which can be applied over `UIButton`:
```swift
elevatedSoft // an embossed button
elevatedSoftRound // a round embossed button
elevatedFlat // flat button
```

Pass button style and text configuration to transform it to neumorphic
```swift
let neumorphicButton = UIButton()
neumorphicButton.applyNeuBtnStyle(type: .elevatedSoft, title: "Soft Button")
```

This button is made up of three layers `baseModel`, `innerModel` and `buttonContentModel` named from bottom to top. `NeuButtonCustomModel` allows you to configure each of these layers and design button.
```swift
let model = NeuConstants.NeuButtonCustomModel()
... some configuration
let customButton = UIButton()
customButton.applyNeuBtnStyle(customModel: model, title: "Custom Button")
```

This library works over base color concept and derives light and dark colors from base color itself. All views and buttons will be using this color to design neumorphic elements. This base color can be set at app start. Similarly, text attributes can be applied at an app-level to give default style to all neumorphic buttons. 
```swift
NeuUtils.baseColor = UIColor.red

let textAttributes: [NSAttributedString.Key:Any] = [:]
textAttributes[.foregroundColor] = .black
NeuUtils.textAttributes = textAttributes
```

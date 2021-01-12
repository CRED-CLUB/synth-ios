# synth
A framework designed over neumorphic style. Provides an extension over UIKit elements `UIView` and `UIButton`.

![Banner](https://i.imgur.com/tKZeAwO.png "Banner")

## Installation
It can be easily integrated with Cocoapods. Add this line to your podfile:
```swift
pod 'synth-ios'
```

## Requirements
- iOS 11.0+
- Swift 5.1+

## Usage

## `Embossed` and `Debossed` views

![Embossed and Debossed Views](https://i.imgur.com/uqfvPE9.png "Embossed and Debossed Views")

As it provides an extension over `UIView`, you can call it over any UI element
```swift
let embossedView = UIView()
embossedView.applyNeuStyle()
```
calling `applyNeuStyle` on any view will give default embossed effect. There is also a helper function `getDebossModel()` in `NeuUIHelper` which provides debossed effect.

```swift
let debossedView = UIView()
debossedView.applyNeuStyle(model: NeuUIHelper.getDebossModel())
```

`applyNeuStyle` function takes two arguments, which lets you configure with your own custom model. `NeuViewModel` has a list of properties to change baseColor, shadow models, light direction, etc.

### `applyNeuStyle` arguments

| attribute | description | value |
|--|--|--|
| `model`| struct which lets you configure base color, shadow direction and shadow offsets | `NeuViewModel` |
| `showOnlyShadows` | enabling this will only render outer or inner shadows skipping the solid background part | Bool |

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

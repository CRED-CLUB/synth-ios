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

### `Embossed` and `Debossed` views

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

### `applyNeuStyle` arguments

| attribute | description | value |
|--|--|--|
| `model`| struct which lets you configure base color, shadow direction and shadow offsets | `NeuViewModel` |
| `showOnlyShadows` | enabling this will only render outer or inner shadows skipping the solid background part | Bool |

### `NeuViewModel` attributes

all colors are by default derived from base color. You can explictly pass different values when needed.

| attribute | description | value |
|--|--|--|
| `baseColor`| base color based on which background and borders are rendered | UIColor |
| `bgGradientColors` | colors array which renders background | [UIColor] |
| `borderGradientColors` | colors array which renders borders | [UIColor] |
| `borderGradientWidth` | outer border width | CGFloat |
| `lightDirection` | an enum which lets define light direction | `NeuLightDirection` |
| `shadowType` | an enum which lets define shadow type, outer or inner | `NeuShadowType` |
| `lightShadowModel` | a model to customise shadow offsets of top shadow | `NeuShadowModel` |
| `darkShadowModel` | a model to customise shadow offsets of bottom shadow | `NeuShadowModel` |
| `blurAmount` | amount of guassian blur that has to be applied | CGFloat |
| `hideLightShadow` | hides top shadow | Bool |
| `hideDarkShadow` | hides bottom shadow | Bool |
| `hideBorder` | hides outer border | Bool |

# buttons

There are by default four styles which can be applied over `UIButton`:
```swift
elevatedSoft // an embossed button
elevatedSoftRound // a round embossed button
elevatedFlat // flat button
elevatedFlatRound // flat button
```

## elevated soft button

![Elevated Soft Button](https://i.imgur.com/HT0L6JT.png "Elevated Soft Button")

```swift
let softButton = UIButton()
softButton.applyNeuBtnStyle(type: .elevatedSoft, title: "Idle")
```

![Elevated Soft with image Button](https://i.imgur.com/1vc67oB.png "Elevated Soft with image Button")
you can also add an image aligned left to this image. synth will render a neumorphic pit on which the image is rendered.
```swift
softButton.applyNeuBtnStyle(type: .elevatedSoft, title: "Idle", image: UIImage(named: "plus"), imageDimension: 12)
```

## elevated soft round button

![elevated soft round button](https://i.imgur.com/igONywf.png "elevated soft round button")

```swift
let roundButton = UIButton()
roundButton.applyNeuBtnStyle(type: .elevatedSoftRound, image: UIImage(named: "plus"))
```

## elevated flat button

![Elevated Flat Button](https://i.imgur.com/yWlyeyK.png "Flat Button")

Elevated flat button renders a flat surface on top of the elevated neumorphic platform. this flat surface can be customized in two ways:
```swift
let flatButton = UIButton()
flatButton.applyNeuBtnStyle(type: .elevatedFlat, title: "Idle")
```

## elevated flat round button

![Elevated Flat Round Button](https://i.imgur.com/yWlyeyK.png "Elevated Flat Round Button")

```swift
let flatButton = UIButton()
flatButton.applyNeuBtnStyle(type: .elevatedFlatRound, title: "Spin")
```

## all button attributes
| attribute | description | value |
|--|--|--|
|`app:neuButtonType`| type of the button | `elevated_flat` or `elevated_soft` |
|`app:neuButtonRadius` | corner radius of button | dimension |
| `app:neuPlatformColor` | color of neumorphic platform | color |
| `app:neuPlatformAppearance` | appearance of neumorphic platform | style resource |
| `app:neuFlatButtonColor` | color of flat button surface | color |
| `app:neuFlatButtonAppearance` | appearance of flat button surface | style resource |
| `app:neuButtonDrawable` | drawable resource of left icon | drawable resource |
| `app:neuButtonDrawablePitRadius` | radius of the pit behind the icon | dimension |
| `app:neuButtonIconAppearance` | appearance of the pit behind the icon | style resource |
| `app:neuButtonCompatColor` | color of button on compat devices | color |

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

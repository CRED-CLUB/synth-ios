# Synth
Synth is CRED's inbuilt library for using Neuromorphic components in your app.

What really is Neumorphism? It's an impressionistic style, playing with light, shadow, and depth to create a digital experience inspired by the physical world. That's the definition anyway. Our recommendation is you try it out to see what you make of it. If you do create something with Synth, let us know. We're excited to see where you take it.

A note for the curious: if you wish to learn more about Synth, we have a post detailing the concept and CRED's philosophy behind it [here](https://blog.cred.club/team-cred/design/world-meet-neumorphism-open-sourcing-our-ui-framework/).

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

### Embossed and Debossed views

![Embossed and Debossed Views](https://i.imgur.com/BVirv0g.png "Embossed and Debossed Views")

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

# Buttons

There are by default four styles which can be applied over `UIButton`:
```swift
elevatedSoft // an embossed button
elevatedSoftRound // a round embossed button
elevatedFlat // flat button
elevatedFlatRound // flat round button
```

## Elevated soft button

![Elevated Soft Button](https://i.imgur.com/ih0WqFz.png "Elevated Soft Button")

```swift
let softButton = UIButton()
softButton.applyNeuBtnStyle(type: .elevatedSoft, title: "Idle")
```

## Elevated soft round button

![Elevated soft round Button](https://i.imgur.com/eP17O6M.png "Elevated soft round Button")

```swift
let roundButton = UIButton()
roundButton.applyNeuBtnStyle(type: .elevatedSoftRound, image: UIImage(named: "plus"))
```

## Elevated flat button

![Elevated Flat Button](https://i.imgur.com/tgVOK5L.png "Elevated Flat Button")

Elevated flat button renders a flat surface on top of the elevated neumorphic platform. this flat surface can be customized in two ways:
```swift
let flatButton = UIButton()
flatButton.applyNeuBtnStyle(type: .elevatedFlat, title: "Idle")
```

![Drawable Button](https://i.imgur.com/Bnjb5Cj.png "Drawable Button")

you can also add an image aligned left to this image. synth will render a neumorphic pit on which the image is rendered.
```swift
softButton.applyNeuBtnStyle(type: .elevatedSoft, title: "Idle", image: UIImage(named: "plus"), imageDimension: 12)
softButton.applyNeuBtnStyle(type: .elevatedFlat, title: "Idle", image: UIImage(named: "plus"), imageDimension: 12)
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

## Contributing

Pull requests are welcome! We'd love help improving this library. Feel free to browse through open issues to look for things that need work. If you have a feature request or bug, please open a new issue so we can track it.

## Contributors

Synth would not have been possible if not for the contributions made by CRED's design and frontend teams.

## License

```
Copyright 2020 Dreamplug Technologies Private Limited.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

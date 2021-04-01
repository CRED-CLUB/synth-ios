//
//  NeuConstants.swift
//  Synth
//
//  Copyright 2020 Dreamplug Technologies Private Limited
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

import UIKit

public struct NeuConstants {
    
    /// Defines all light directions. This property can be used to change direction of light source in `NeuViewModel` and `NeuButtonContentModel`
    public enum NeuLightDirection {
        case left
        case topLeft
        case top
        case topRight
        case right
        case bottomRight
        case bottom
        case bottomLeft
        case base
    }

    /// Defines whether view has outer or inner shadow
    public enum NeuShadowType {
        case outer
        case inner
    }
    
    /// Defines button types
    public enum NeuButtonType: String {
        case elevatedSoft = "elevated_soft" // embossed button
        case elevatedSoftRound = "elevated_soft_round"  // round embossed button
        case elevatedFlat = "elevated_flat" // flat embossed button
        case elevatedFlatRound = "elevated_flat_round" // round flat embossed button
    }

    /// Defines button states
    public enum NeuButtonState {
        case normal
        case pressed
        case disabled
    }

    public struct NeuShadowModel {
        public var xOffset: CGFloat
        public var yOffset: CGFloat
        public var blur: CGFloat
        public var spread: CGFloat
        public var color: UIColor
        public var opacity: Float

        public init(xOffset: CGFloat = 0, yOffset: CGFloat = 0, blur: CGFloat = 0, spread: CGFloat = 0, color: UIColor = .clear, opacity: Float = 0) {
            self.xOffset = xOffset
            self.yOffset = yOffset
            self.blur = blur
            self.spread = spread
            self.color = color
            self.opacity = opacity
        }
    }

    /// Defines properties to construct neu view
    ///
    /// - baseColor: color from which all gradients and shadows are created, takes basecolor defined in NeuUtils by default
    ///           if default value of properties are required, set only baseColor
    /// - bgGradientColors: gradient applied to background layer
    /// - borderGradientColors: gradient colors applied to view border
    /// - borderGradientWidth: width of gradient border
    /// - lightDirection: light direction of source based on which background gradient and shadows are rendered
    /// - shadowType: one of NeuShadowType based on which shadows are rendered outer or inner
    /// - lightShadowModel: lighter shadow configuration
    /// - darkShadowModel: darker shadow configuration
    /// - shadowBlur: default amount of shadow blur applied on lighter and darker shadows, gets negated if light and dark shadow model is set
    /// - blurAmount: amount of blur applied to view after gradients, border and shadows are rendered
    /// - hideLightShadow: hides light shadow component if true, default value is false
    /// - hideDarkShadow: hides dark shadow component if true, default value is false
    /// - hideBorder: hides gradient layer applied to border
    public struct NeuViewModel {

        public var baseColor: UIColor
        public var bgGradientColors: [CGColor]?
        public var borderGradientColors: [CGColor]?
        public var borderGradientWidth: CGFloat
        public var lightDirection: NeuLightDirection
        public var shadowType: NeuShadowType
        public var lightShadowModel: NeuShadowModel
        public var darkShadowModel: NeuShadowModel
        public var shadowBlur: CGFloat
        public var blurAmount: CGFloat
        public var hideLightShadow: Bool
        public var hideDarkShadow: Bool
        public var hideBorder: Bool

        public init(baseColor: UIColor = NeuUtils.baseColor, isRectangle: Bool = true) {
            self.baseColor = baseColor
            bgGradientColors = isRectangle ? nil : [baseColor.darken(fraction: 0.1).cgColor, baseColor.lighten(fraction: 0.03).cgColor]
            borderGradientColors = [baseColor.lighten(fraction: 0.04).cgColor, baseColor.darken(fraction: 0.2).cgColor]
            borderGradientWidth = 0.7
            lightDirection = .base
            shadowType = .inner
            lightShadowModel = isRectangle ? NeuShadowModel(xOffset: -3, yOffset: -1, blur: 6, spread: 0, color: baseColor.lighten(fraction: 0.95), opacity: 0.5) : NeuShadowModel(xOffset: -3, yOffset: -1, blur: 2, spread: 0, color: baseColor.lighten(fraction: 0.7), opacity: 0.3)
            darkShadowModel = NeuShadowModel(xOffset: 3, yOffset: 3, blur: isRectangle ? 6 : 5, spread: 0, color: baseColor.darken(fraction: 0.95), opacity: isRectangle ? 0.8 : 0.6)
            shadowBlur = 4
            blurAmount = 2
            hideLightShadow = false
            hideDarkShadow = false
            hideBorder = false
        }
    }
    
    
    public struct NeuButtonModel {
        public var viewModel: NeuViewModel
        public var normalBgGradientColors: [CGColor]?
        public var highlightedBgGradientColors: [CGColor]?
        
        public init() {
            viewModel = NeuViewModel()
            normalBgGradientColors = viewModel.bgGradientColors
            highlightedBgGradientColors = viewModel.bgGradientColors
        }
    }
    
    public struct NeuButtonContentModel {
        
        public var lightDirection: NeuLightDirection
        public var normalShadowModel: NeuShadowModel?
        public var highlightedShadowModel: NeuShadowModel?
        public var normalBgGradientColors: [CGColor]?
        public var highlightedBgGradientColors: [CGColor]?
        public var normalBorderGradients: [BorderGradientLayerModel]?
        public var highlightedBorderGradients: [BorderGradientLayerModel]?
        public var normalInnerShadows: [NeuShadowModel]?
        public var highlightedInnerShadows: [NeuShadowModel]?
        public var normalCircleGradientColors: [CGColor]?
        public var highlightedCircleGradientColors: [CGColor]?
        public var circleBlurAmount: CGFloat?
        public var contentPadding: CGFloat?
        public var stackContentPadding: CGFloat?

        public init() {
            self.lightDirection = .base
        }
    }
    
    public struct BorderGradientLayerModel {
        let lightDirection: NeuConstants.NeuLightDirection
        let colors: [CGColor]
        let borderWidth: CGFloat
    }
    
    /// Defines custom model to create neu button
    ///
    /// - baseModel: configuration for bottom most layer
    /// - innerModel: configuration for middle layer
    /// - buttonContentModel: configuration for top most layer
    public struct NeuButtonCustomModel {
        public var baseModel: NeuButtonModel?
        public var innerModel: NeuViewModel?
        public var buttonContentModel: NeuButtonContentModel?
        public var contentPadding: CGFloat?
        
        public init() {
            self.baseModel = NeuButtonModel()
            self.innerModel = nil
            self.buttonContentModel = NeuButtonContentModel()
            self.contentPadding = 5
        }
    }
}

//
//  NeuUtils.swift
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

public struct NeuUtils {

    private static var neuColor = UIColor.fromHex("212426")
    private static var neuTextAttributes: [NSAttributedString.Key:Any] = [:]

    /// This baseColor is used to generate content gradient, shadows and borders. Changing this will update baseColor across NeumorphicUIKit
    public static var baseColor: UIColor {
        get {
            return neuColor
        }
        set {
            neuColor = newValue
        }
    }
    
    /// Sets common text attributes which are applied to title property in UIButton created from `applyNeuButtonStyle`
    public static var textAttributes: [NSAttributedString.Key:Any] {
        get {
            return neuTextAttributes
        }
        set {
            neuTextAttributes = newValue
        }
    }
    
    /// Gets button base model from given button type
    public static func getButtonModel(for buttonType: NeuConstants.NeuButtonType) -> NeuConstants.NeuButtonModel {

        var buttonModel = NeuConstants.NeuButtonModel()
        var baseModel = NeuConstants.NeuViewModel()

        switch buttonType {
        case .elevatedSoft:
            baseModel.shadowType = .outer
            baseModel.bgGradientColors = [baseColor.lighten(fraction: 0.045).cgColor, baseColor.darken(fraction: 0.3).cgColor]
            baseModel.borderGradientColors = [baseColor.lighten(fraction: 0.05).cgColor, baseColor.darken(fraction: 0.25).cgColor]
            baseModel.lightShadowModel = NeuConstants.NeuShadowModel(xOffset: -8, yOffset: -8, blur: 20, spread: -2, color: baseColor.lighten(fraction: 0.8), opacity: 0.15)
            baseModel.darkShadowModel = NeuConstants.NeuShadowModel(xOffset: 8, yOffset: 8, blur: 18, spread: -1, color: baseColor.darken(fraction: 0.8), opacity: 0.7)
            baseModel.blurAmount = 2
            
            buttonModel.normalBgGradientColors = baseModel.bgGradientColors
            buttonModel.highlightedBgGradientColors = [baseColor.darken(fraction: 0.3).cgColor, baseColor.lighten(fraction: 0.04).cgColor]
        case .elevatedSoftRound:
            baseModel.shadowType = .outer
            baseModel.bgGradientColors = [baseColor.lighten(fraction: 0.045).cgColor, baseColor.darken(fraction: 0.3).cgColor]
            baseModel.borderGradientColors = [baseColor.lighten(fraction: 0.05).cgColor, baseColor.darken(fraction: 0.25).cgColor]
            baseModel.lightShadowModel = NeuConstants.NeuShadowModel(xOffset: -6, yOffset: -6, blur: 20, spread: -2, color: baseColor.lighten(fraction: 0.9), opacity: 0.15)
            baseModel.darkShadowModel = NeuConstants.NeuShadowModel(xOffset: 6, yOffset: 6, blur: 18, spread: -1, color: baseColor.darken(fraction: 0.9), opacity: 0.7)
            baseModel.blurAmount = 2
            
            buttonModel.normalBgGradientColors = baseModel.bgGradientColors
            buttonModel.highlightedBgGradientColors = [baseColor.darken(fraction: 0.3).cgColor, baseColor.lighten(fraction: 0.04).cgColor]
        case .elevatedFlat:
            baseModel.shadowType = .outer
            baseModel.blurAmount = 0
            baseModel.bgGradientColors = [baseColor.lighten(fraction: 0.055).cgColor, baseColor.darken(fraction: 0.25).cgColor]
            baseModel.lightShadowModel = NeuConstants.NeuShadowModel(xOffset: -5, yOffset: -3, blur: 25, spread: -11, color: baseColor.lighten(fraction: 0.4), opacity: 0.4)
            baseModel.darkShadowModel = NeuConstants.NeuShadowModel(xOffset: 11, yOffset: 6, blur: 12, spread: -11, color: baseColor.darken(fraction: 0.9), opacity: 0.5)
            
            buttonModel.normalBgGradientColors = baseModel.bgGradientColors
            buttonModel.highlightedBgGradientColors = baseModel.bgGradientColors
        case .elevatedFlatRound:
            baseModel.bgGradientColors = [baseColor.darken(fraction: 0.3).cgColor, baseColor.lighten(fraction: 0.03).cgColor]
            
            buttonModel.normalBgGradientColors = baseModel.bgGradientColors
            buttonModel.highlightedBgGradientColors = baseModel.bgGradientColors
        }

        buttonModel.viewModel = baseModel
        return buttonModel
    }
    
    /// Gets button inner view model for given button type
    public static func getButtonInnerModel(for buttonType: NeuConstants.NeuButtonType) -> NeuConstants.NeuViewModel? {
        switch buttonType {
        case .elevatedSoft, .elevatedSoftRound, .elevatedFlatRound:
            return nil
        case .elevatedFlat:
            return getButtonModel(for: .elevatedSoft).viewModel
        }
    }
    
    /// Gets button content model for given button type
    public static func getButtonContentModel(for buttonType: NeuConstants.NeuButtonType) -> NeuConstants.NeuButtonContentModel {
        
        var model = NeuConstants.NeuButtonContentModel()

        switch buttonType {
        case .elevatedSoft:
            model.normalCircleGradientColors = [baseColor.darken(fraction: 0.25).cgColor, baseColor.lighten(fraction: 0.055).cgColor]
            model.highlightedCircleGradientColors = [baseColor.darken(fraction: 0.5).cgColor, baseColor.lighten(fraction: 0.055).cgColor]
            model.circleBlurAmount = 3
            model.contentPadding = 5
            model.stackContentPadding = 0
        case .elevatedSoftRound:
            model.contentPadding = 5
            model.stackContentPadding = 0
            break
        case .elevatedFlat:
            model.normalShadowModel = NeuConstants.NeuShadowModel(xOffset: 1, yOffset: 2, blur: 15, spread: 0, color: .black, opacity: 0.45)
            model.normalBgGradientColors = [UIColor.fromHex("426BB6").cgColor, UIColor.fromHex("26458C").cgColor]
            model.highlightedBgGradientColors = model.normalBgGradientColors
            
            var borderGradients: [NeuConstants.BorderGradientLayerModel] = []
            borderGradients.append(NeuConstants.BorderGradientLayerModel(lightDirection: .base, colors: [UIColor.fromHex("5679C4").cgColor, UIColor.fromHex("1B2D5B").cgColor], borderWidth: 0.9))
            borderGradients.append(NeuConstants.BorderGradientLayerModel(lightDirection: .base, colors: [UIColor.fromHex("366BD1").cgColor, UIColor.fromHex("18263E").cgColor], borderWidth: 0.5))
            model.normalBorderGradients = borderGradients
            
            var innerShadows: [NeuConstants.NeuShadowModel] = []
            innerShadows.append(NeuConstants.NeuShadowModel(xOffset: 3, yOffset: 4, blur: 8, spread: 0, color: .black, opacity: 1))
            innerShadows.append(NeuConstants.NeuShadowModel(xOffset: 3, yOffset: 4, blur: 8, spread: 0, color: .black, opacity: 1))
            model.highlightedInnerShadows = innerShadows
            
            model.normalCircleGradientColors = [UIColor.fromHex("243E78").cgColor, UIColor.fromHex("4975C5").cgColor]
            model.highlightedCircleGradientColors = model.normalCircleGradientColors
            model.circleBlurAmount = 3
            model.contentPadding = 4
            model.stackContentPadding = 4
        case .elevatedFlatRound:
            model.normalShadowModel = NeuConstants.NeuShadowModel(xOffset: 1, yOffset: 2, blur: 12, spread: 0, color: .black, opacity: 0.43)
            model.normalBgGradientColors = [UIColor.fromHex("323637").cgColor, UIColor.fromHex("161718").cgColor]
            model.highlightedBgGradientColors = [UIColor.fromHex("181A1B").cgColor, UIColor.fromHex("383B3C").cgColor]
            
            var innerShadows: [NeuConstants.NeuShadowModel] = []
            innerShadows.append(NeuConstants.NeuShadowModel(xOffset: 4, yOffset: 6, blur: 20, spread: 0, color: .black, opacity: 1))
            innerShadows.append(NeuConstants.NeuShadowModel(xOffset: 4, yOffset: 6, blur: 20, spread: 0, color: .black, opacity: 1))
            model.highlightedInnerShadows = innerShadows
            model.contentPadding = 5
            model.stackContentPadding = 0
        }
        
        return model
    }
}

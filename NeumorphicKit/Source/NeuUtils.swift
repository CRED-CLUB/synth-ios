//
//  NeuUtils.swift
//  NeumorphicKit
//
//  Created by Prashant Shrivastava on 12/06/20.
//  Copyright © 2020 CRED. All rights reserved.
//

import UIKit

public struct NeuUtils {

    private static var neuColor = UIColor(red: 33.0/255.0, green: 36.0/255.0, blue: 38.0/255.0, alpha: 1.0)
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
            model.normalBgGradientColors = [UIColor(red: 66.0/255.0, green: 107.0/255.0, blue: 182.0/255.0, alpha: 1.0).cgColor, UIColor(red: 38.0/255.0, green: 69.0/255.0, blue: 140.0/255.0, alpha: 1.0).cgColor]
            model.highlightedBgGradientColors = model.normalBgGradientColors
            
            var borderGradients: [NeuConstants.BorderGradientLayerModel] = []
            borderGradients.append(NeuConstants.BorderGradientLayerModel(lightDirection: .base, colors: [UIColor(red: 86.0/255.0, green: 121.0/255.0, blue: 196.0/255.0, alpha: 1.0).cgColor, UIColor(red: 27.0/255.0, green: 45.0/255.0, blue: 91.0/255.0, alpha: 1.0).cgColor], borderWidth: 0.9))
            borderGradients.append(NeuConstants.BorderGradientLayerModel(lightDirection: .base, colors: [UIColor(red: 54.0/255.0, green: 107.0/255.0, blue: 209.0/255.0, alpha: 1.0).cgColor, UIColor(red: 24.0/255.0, green: 38.0/255.0, blue: 62.0/255.0, alpha: 1.0).cgColor], borderWidth: 0.5))
            model.normalBorderGradients = borderGradients
            
            var innerShadows: [NeuConstants.NeuShadowModel] = []
            innerShadows.append(NeuConstants.NeuShadowModel(xOffset: 3, yOffset: 4, blur: 8, spread: 0, color: .black, opacity: 1))
            innerShadows.append(NeuConstants.NeuShadowModel(xOffset: 3, yOffset: 4, blur: 8, spread: 0, color: .black, opacity: 1))
            model.highlightedInnerShadows = innerShadows
            
            model.normalCircleGradientColors = [UIColor(red: 36.0/255.0, green: 62.0/255.0, blue: 120.0/255.0, alpha: 1.0).cgColor, UIColor(red: 73.0/255.0, green: 117.0/255.0, blue: 197.0/255.0, alpha: 1.0).cgColor]
            model.highlightedCircleGradientColors = model.normalCircleGradientColors
            model.circleBlurAmount = 3
            model.contentPadding = 4
            model.stackContentPadding = 4
        case .elevatedFlatRound:
            model.normalShadowModel = NeuConstants.NeuShadowModel(xOffset: 1, yOffset: 2, blur: 12, spread: 0, color: .black, opacity: 0.43)
            model.normalBgGradientColors = [UIColor(red: 50.0/255.0, green: 54.0/255.0, blue: 55.0/255.0, alpha: 1.0).cgColor, UIColor(red: 22.0/255.0, green: 23.0/255.0, blue: 24.0/255.0, alpha: 1.0).cgColor]
            model.highlightedBgGradientColors = [UIColor(red: 24.0/255.0, green: 26.0/255.0, blue: 27.0/255.0, alpha: 1.0).cgColor, UIColor(red: 56.0/255.0, green: 59.0/255.0, blue: 60.0/255.0, alpha: 1.0).cgColor]
            
            var innerShadows: [NeuConstants.NeuShadowModel] = []
            innerShadows.append(NeuConstants.NeuShadowModel(xOffset: 4, yOffset: 6, blur: 20, spread: 0, color: .black, opacity: 1))
            innerShadows.append(NeuConstants.NeuShadowModel(xOffset: 4, yOffset: 6, blur: 20, spread: 0, color: .black, opacity: 1))
            model.highlightedInnerShadows = innerShadows
            model.contentPadding = 5
        }
        
        return model
    }
}

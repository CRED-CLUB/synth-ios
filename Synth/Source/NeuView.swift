//
//  NeuView.swift
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

class NeuView: UIView {

    private var backgroundLayer: CALayer?
    private var borderGradientLayer: CAGradientLayer?
    private var lightShadowLayer: CALayer?
    private var darkShadowLayer: CALayer?
    private var blurredView: UIView = UIView()

    private var model: NeuConstants.NeuViewModel!
    private var showOnlyShadows: Bool!
    private var blurredImageView = UIImageView()

    // MARK: Initializers
    
    init(frame: CGRect, cornerRadius: CGFloat, model: NeuConstants.NeuViewModel, showOnlyShadows: Bool = false) {
        self.model = model
        self.showOnlyShadows = showOnlyShadows
        super.init(frame: frame)
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
        configure(with: model)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Public

    /// Used to update view contents when bounds changes
    func resizeContentView(to bounds: CGRect) {
        frame = bounds
        updateViewLayers()
    }

    /// Returns blurred image of view in current state
    func getBlurredImage() -> UIImage? {
        return blurredImageView.image
    }

    /// Updates view layers when model changes
    func configure(with model: NeuConstants.NeuViewModel) {
        self.model = model
        updateViewLayers()
    }
    
    // MARK: Private

    private func updateViewLayers() {

        blurredView.frame = bounds
        blurredView.clipsToBounds = false
        setupBackgroundLayer()
        setupBorderGradientLayer()
        setupInnerLightShadowLayer()
        setupInnerDarkShadowLayer()
        blurView()
    }

    private func setupBackgroundLayer() {

        guard !showOnlyShadows else { return }

        backgroundLayer = CALayer()
        backgroundLayer?.frame = bounds
        backgroundLayer?.cornerRadius = layer.cornerRadius

        let colors = model.bgGradientColors ?? [model.baseColor.cgColor]
        backgroundLayer?.addSkewedGradientLayer(colors: colors)
    }

    private func setupBorderGradientLayer() {

        guard !model.hideBorder, let colors = model.borderGradientColors else { return }
        borderGradientLayer = NeuUIHelper.borderGradientLayer(gradientModel: NeuConstants.BorderGradientLayerModel(lightDirection: model.lightDirection, colors: colors, borderWidth: model.borderGradientWidth), bounds: bounds, cornerRadius: layer.cornerRadius)
    }

    private func setupInnerLightShadowLayer() {

        guard !model.hideLightShadow else { return }

        let (xOffset, yOffset) = getShadowAttributes(isLightShadow: true)
        lightShadowLayer = CALayer()
        lightShadowLayer?.frame = bounds
        lightShadowLayer?.cornerRadius = layer.cornerRadius
        lightShadowLayer?.addInnerShadow(shadowColor: model.lightShadowModel.color, shadowOpacity: model.lightShadowModel.opacity, blur: model.lightShadowModel.blur, xOffset: xOffset, yOffset: yOffset)
    }

    private func setupInnerDarkShadowLayer() {

        guard !model.hideDarkShadow else { return }

        let (xOffset, yOffset) = getShadowAttributes(isLightShadow: false)
        darkShadowLayer = CALayer()
        darkShadowLayer?.frame = bounds
        darkShadowLayer?.cornerRadius = layer.cornerRadius
        darkShadowLayer?.addInnerShadow(shadowColor: model.darkShadowModel.color, shadowOpacity: model.darkShadowModel.opacity, blur: model.darkShadowModel.blur, xOffset: xOffset, yOffset: yOffset)
    }

    private func setupOuterDarkShadowLayer(bounds: CGRect) {

        guard !model.hideDarkShadow else { return }

        let (xOffset, yOffset) = getShadowAttributes(isLightShadow: false)
        darkShadowLayer = CALayer()
        darkShadowLayer?.frame = bounds
        darkShadowLayer?.cornerRadius = layer.cornerRadius
        darkShadowLayer?.applyShadow(color: model.darkShadowModel.color, alpha: model.darkShadowModel.opacity, x: xOffset, y: yOffset, blur: model.darkShadowModel.blur, spread: model.darkShadowModel.spread)
    }

    private func setupOuterLightShadowLayer(bounds: CGRect) {

        guard !model.hideLightShadow else { return }

        let (xOffset, yOffset) = getShadowAttributes(isLightShadow: true)
        lightShadowLayer = CALayer()
        lightShadowLayer?.frame = bounds
        lightShadowLayer?.cornerRadius = layer.cornerRadius
        lightShadowLayer?.applyShadow(color: model.lightShadowModel.color, alpha: model.lightShadowModel.opacity, x: xOffset, y: yOffset, blur: model.lightShadowModel.blur, spread: model.lightShadowModel.spread)
    }

    private func blurView() {

        let view = UIView(frame: bounds)

        if model.shadowType == .inner {
            if let backgroundLayerT = backgroundLayer {
                view.layer.addSublayer(backgroundLayerT)
            }
            if let lightShadowLayerT = lightShadowLayer {
                view.layer.addSublayer(lightShadowLayerT)
            }
            if let darkShadowLayerT = darkShadowLayer {
                view.layer.addSublayer(darkShadowLayerT)
            }
        } else {
            if let backgroundLayerT = backgroundLayer {
                view.layer.addSublayer(backgroundLayerT)
            }
        }

        if let borderGradientLayerT = borderGradientLayer {
            view.layer.addSublayer(borderGradientLayerT)
        }

        NeuUIHelper.removeAllSubViews(view: blurredView)
        NeuUIHelper.removeAllSublayers(view: blurredView)
        
        guard model.blurAmount > 0, let blurredImage = view.applyBlur(with: model.blurAmount) else {

            if model.shadowType == .outer {
                setupOuterLightShadowLayer(bounds: bounds)
                setupOuterDarkShadowLayer(bounds: bounds)
                if let darkShadowLayerT = darkShadowLayer {
                    blurredView.layer.addSublayer(darkShadowLayerT)
                }
                if let lightShadowLayerT = lightShadowLayer {
                    blurredView.layer.addSublayer(lightShadowLayerT)
                }
            }

            blurredView.addSubview(view)

            if !blurredView.isDescendant(of: self) {
                addSubview(blurredView)
            }
            sendSubviewToBack(blurredView)
            return
        }

        let boundingRect = CGRect(x: -model.blurAmount * 4, y: -model.blurAmount * 4, width: bounds.width + model.blurAmount * 8, height: bounds.height + model.blurAmount * 8)
        if model.shadowType == .outer {
            setupOuterLightShadowLayer(bounds: bounds)
            setupOuterDarkShadowLayer(bounds: bounds)
            if let darkShadowLayerT = darkShadowLayer {
                blurredView.layer.addSublayer(darkShadowLayerT)
            }
            if let lightShadowLayerT = lightShadowLayer {
                blurredView.layer.addSublayer(lightShadowLayerT)
            }
        }

        blurredImageView.frame = boundingRect
        blurredImageView.image = blurredImage
        blurredView.addSubview(blurredImageView)

        if showOnlyShadows {
            blurredImageView.isUserInteractionEnabled = false
            blurredView.isUserInteractionEnabled = false
            isUserInteractionEnabled = false
        }
        if !blurredView.isDescendant(of: self) {
            addSubview(blurredView)
        }
        sendSubviewToBack(blurredView)
    }

    private func getShadowAttributes(isLightShadow: Bool) -> (CGFloat, CGFloat) {

        var xOffset: CGFloat = 0, yOffset: CGFloat = 0
        let shadowBlur = model.shadowBlur
        switch model.lightDirection {
        case .left:
            xOffset = -shadowBlur
        case .topLeft:
            xOffset = -shadowBlur
            yOffset = -shadowBlur
        case .top:
            yOffset = -shadowBlur
        case .topRight:
            xOffset = shadowBlur
            yOffset = -shadowBlur
        case .right:
            xOffset = shadowBlur
        case .bottomRight:
            xOffset = shadowBlur
            yOffset = shadowBlur
        case .bottom:
            yOffset = shadowBlur
        case .bottomLeft:
            xOffset = -shadowBlur
            yOffset = shadowBlur
        case .base:
            // xOffset and yOffset is negative in dark shadow case as it gets negated in return statement
            if isLightShadow {
                xOffset = model.lightShadowModel.xOffset
                yOffset = model.lightShadowModel.yOffset
            } else {
                xOffset = -model.darkShadowModel.xOffset
                yOffset = -model.darkShadowModel.yOffset
            }
        }
        return isLightShadow ? (xOffset, yOffset) : (-xOffset, -yOffset)
    }
}

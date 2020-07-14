//
//  NeuButton.swift
//  NeumorphicKit
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

class NeuButtonView: UIView {

    private var baseView: NeuView!
    private var baseInnerView: NeuView!
    private var buttonContent: NeuButtonContent!

    private var type: NeuConstants.NeuButtonType = .elevatedSoft
    private var baseModel = NeuConstants.NeuButtonModel()
    private var isHighlighted: Bool = false
    private var isEnabled: Bool = true
    private var contentNormalPadding: CGFloat = 5
    private var contentType4Padding: CGFloat = 4
    private var customModel: NeuConstants.NeuButtonCustomModel? = nil

    /// Used to get current button state
    var neuButtonState: NeuConstants.NeuButtonState {
        get {
            return buttonContent.state
        }
    }

    // MARK: - init methods

    init(frame: CGRect, type: NeuConstants.NeuButtonType) {
        self.type = type
        super.init(frame: frame)
        preSetupConfiguration()
        setupViews()
    }
    
    init(frame: CGRect, customModel: NeuConstants.NeuButtonCustomModel) {
        self.customModel = customModel
        super.init(frame: frame)
        preSetupConfiguration()
        setupCustomViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - public methods

    /// Used to update subviews when bounds changes
    func resizeContentView(to bounds: CGRect) {
        
        frame = bounds
        layer.cornerRadius = bounds.height/2
        layer.masksToBounds = false
        baseView.resizeContentView(to: bounds)
        if baseInnerView != nil {
            baseInnerView.resizeContentView(to: bounds)
        }
        buttonContent.resizeContentView(to: getContentBounds(bounds: bounds))
        updateBaseView()
    }
    
    /// sets title and image properties in neu button content
    func setNeuButtonContent(title: String? = nil, attributedTitle: NSAttributedString? = nil, image: UIImage? = nil, imageTintColor: UIColor = .clear, imageDimension: CGFloat = 20) {
        
        let attributedText: NSAttributedString?
        if let titleT = title {
            attributedText = NSAttributedString(string: titleT, attributes: NeuUtils.textAttributes)
        } else {
            attributedText = attributedTitle
        }
        buttonContent.setAttributedTitle(title: attributedText, with: image, imageTintColor: imageTintColor, imageDimension: imageDimension)
    }

    /// Called when isHighlighted property changes
    func toggleHighlightState(isHighlighted: Bool) {

        guard self.isHighlighted != isHighlighted else { return }
        self.isHighlighted = isHighlighted
        updateBaseView()
    }

    /// Called when isEnabled property changes
    func toggleEnabledState(isEnabled: Bool) {
        self.isEnabled = isEnabled
        updateBaseView()
    }

    // MARK: - private methods

    private func preSetupConfiguration() {
        layer.cornerRadius = frame.height/2
        layer.masksToBounds = false
        isUserInteractionEnabled = false
    }
    
    private func setupViews() {

        baseModel = NeuUtils.getButtonModel(for: type)
        baseView = NeuView(frame: bounds, cornerRadius: layer.cornerRadius, model: baseModel.viewModel)
        addSubview(baseView)

        if let baseInnerModel = NeuUtils.getButtonInnerModel(for: type) {
            baseInnerView = NeuView(frame: bounds, cornerRadius: layer.cornerRadius, model: baseInnerModel)
            addSubview(baseInnerView)
        }

        buttonContent = NeuButtonContent(frame: getContentBounds(bounds: bounds), contentModel: NeuUtils.getButtonContentModel(for: type))
        addSubview(buttonContent)
    }
    
    private func setupCustomViews() {

        baseModel = customModel?.baseModel ?? baseModel
        baseView = NeuView(frame: bounds, cornerRadius: layer.cornerRadius, model: baseModel.viewModel)
        addSubview(baseView)

        if let innerModel = customModel?.innerModel {
            baseInnerView = NeuView(frame: bounds, cornerRadius: layer.cornerRadius, model: innerModel)
            addSubview(baseInnerView)
        }

        let buttonContentModel = customModel?.buttonContentModel ?? NeuConstants.NeuButtonContentModel()
        buttonContent = NeuButtonContent(frame: getContentBounds(bounds: bounds), contentModel: buttonContentModel)
        addSubview(buttonContent)
    }

    private func getContentBounds(bounds: CGRect) -> CGRect {
        let contentPadding = type == .elevatedFlat ? contentType4Padding : contentNormalPadding
        return bounds.inset(by: UIEdgeInsets(top: contentPadding, left: contentPadding, bottom: contentPadding, right: contentPadding))
    }

    private func updateBaseView() {
        baseModel.viewModel.bgGradientColors = (isHighlighted || !isEnabled) ? baseModel.highlightedBgGradientColors : baseModel.normalBgGradientColors
        baseView.configure(with: baseModel.viewModel)
        buttonContent.state = isHighlighted ? .pressed : (isEnabled ? .normal : .disabled)
    }
}

//
//  NeuButton.swift
//  NeumorphicKit
//
//  Created by Prashant Shrivastava on 12/06/20.
//  Copyright © 2020 CRED. All rights reserved.
//

import UIKit

class NeuButtonView: UIView {

    private var baseView: NeuView!
    private var baseInnerView: NeuView!
    private var buttonContent: NeuButtonContent!

    private var type: NeuConstants.NeuButtonType!
    private var baseModel: NeuConstants.NeuButtonModel!
    private var customModel: NeuConstants.NeuButtonCustomModel!
    private var contentPadding: CGFloat!
    private var hideBaseView: Bool!

    private var isHighlighted: Bool = false
    private var isEnabled: Bool = true

    /// Used to get current button state
    var neuButtonState: NeuConstants.NeuButtonState {
        get {
            return buttonContent.state
        }
    }

    // MARK: - init methods

    init(frame: CGRect, type: NeuConstants.NeuButtonType, hideBaseView: Bool) {
        self.type = type
        self.hideBaseView = hideBaseView
        self.contentPadding = NeuUtils.getContentPadding(for: type)
        super.init(frame: frame)
        preSetupConfiguration()
        setupViews()
    }
    
    init(frame: CGRect, customModel: NeuConstants.NeuButtonCustomModel, hideBaseView: Bool) {
        self.customModel = customModel
        self.hideBaseView = hideBaseView
        self.contentPadding = customModel.contentPadding
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
        buttonContent.resizeContentView(to: getContentBounds(bounds: bounds, padding: contentPadding))
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

        buttonContent = NeuButtonContent(frame: getContentBounds(bounds: bounds, padding: contentPadding), contentModel: NeuUtils.getButtonContentModel(for: type))
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
        buttonContent = NeuButtonContent(frame: getContentBounds(bounds: bounds, padding: contentPadding), contentModel: buttonContentModel)
        addSubview(buttonContent)
        
        if hideBaseView {
            baseView.isHidden = true
            if baseInnerView != nil {
                baseInnerView.isHidden = true
            }
        }
    }

    private func getContentBounds(bounds: CGRect, padding: CGFloat) -> CGRect {
        return hideBaseView ? bounds : bounds.inset(by: UIEdgeInsets(top: contentPadding, left: contentPadding, bottom: contentPadding, right: contentPadding))
    }

    private func updateBaseView() {
        baseModel.viewModel.bgGradientColors = (isHighlighted || !isEnabled) ? baseModel.highlightedBgGradientColors : baseModel.normalBgGradientColors
        baseView.configure(with: baseModel.viewModel)
        buttonContent.state = isHighlighted ? .pressed : (isEnabled ? .normal : .disabled)
    }
}

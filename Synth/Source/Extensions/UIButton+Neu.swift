//
//  UIButton+Neu.swift
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

public extension UIButton {
    
    /// Adds a neumorphic view on UIButton and moves it to background
    /// - Parameters:
    ///   - type: one of NeuButtonType enum
    ///   - title: sets title to UIButton, uses default text attributes supplied to `NeuUtils`
    ///   - attributedTitle: sets attributed title
    ///   - image: sets image to UIButton, this image is aligned to left if both image and text present
    ///   - imageTintColor: sets tint color of UIImageView, default value is transparent
    ///   - imageDimension: sets image dimension of UIImageView, default image dimension is 20 (aspectRatio of image is 1:1)
    func applyNeuBtnStyle(type: NeuConstants.NeuButtonType, title: String? = nil, attributedTitle: NSAttributedString? = nil, image: UIImage? = nil, imageTintColor: UIColor = .clear, imageDimension: CGFloat = 20, hideBasePit: Bool = false, hideImagePit: Bool = false) {

        preNeuBtnStyleSetup()
        setupNeuButtonViewHolder(type: type, hideBasePit: hideBasePit, hideImagePit: hideImagePit)
        updateNeuBtnContent(title: title, attributedTitle: attributedTitle, image: image, imageTintColor: imageTintColor, imageDimension: imageDimension)
    }
    
    /// Adds a custom neumorphic view based on given custom model and moves it to background
    /// - Parameters:
    ///   - model: a custom neu button model which is used to create button layers
    ///            contains three layers: base, content and inner content
    ///            custom model can be passed to configure each layer individually so that they are mutually independant of each other
    ///
    /// title, attributedTitle, image, imageTintColor and imageDimension works same as above
    func applyCustomNeuBtnStyle(model: NeuConstants.NeuButtonCustomModel, title: String? = nil, attributedTitle: NSAttributedString? = nil, image: UIImage? = nil, imageTintColor: UIColor = .clear, imageDimension: CGFloat = 20, hideBasePit: Bool = false, hideImagePit: Bool = false) {
        
        preNeuBtnStyleSetup()
        setupNeuButtonViewHolder(customModel: model, hideBasePit: hideBasePit, hideImagePit: hideImagePit)
        updateNeuBtnContent(title: title, attributedTitle: attributedTitle, image: image, imageTintColor: imageTintColor, imageDimension: imageDimension)
    }
    
    func updateNeuBtnContent(title: String?, attributedTitle: NSAttributedString?, image: UIImage?, imageTintColor: UIColor, imageDimension: CGFloat) {

        if let neuButtonView = neuButtonViewDataHolder?.neuButtonView {
            if !neuButtonView.isDescendant(of: self) {
                addSubview(neuButtonView)
                sendSubviewToBack(neuButtonView)
            }
            setTitle(title, for: .normal)
            setAttributedTitle(attributedTitle, for: .normal)
            layoutIfNeeded()
            
            neuButtonView.setNeuButtonContent(title: title, attributedTitle: attributedTitle, image: image, imageTintColor: imageTintColor, imageDimension: imageDimension)
            
            if let label = titleLabel {
                sendSubviewToBack(label)
                label.isHidden = true
            }
        }
    }
    
    private func preNeuBtnStyleSetup() {
        layer.masksToBounds = false
        titleLabel?.text = nil
        backgroundColor = .clear
    }
    
    private func setupNeuButtonViewHolder(type: NeuConstants.NeuButtonType? = nil, customModel: NeuConstants.NeuButtonCustomModel? = nil, hideBasePit: Bool, hideImagePit: Bool) {
        
        guard type != nil || customModel != nil else { return }
        if neuButtonViewDataHolder == nil {
            var neuButtonView: NeuButtonView? = nil
            if let typeT = type {
                neuButtonView = NeuButtonView(frame: bounds, type: typeT, hideBasePit: hideBasePit, hideImagePit: hideImagePit)
            } else if let customModelT = customModel {
                neuButtonView = NeuButtonView(frame: bounds, customModel: customModelT, hideBasePit: hideBasePit, hideImagePit: hideImagePit)
            }
            
            guard let neuButtonViewT = neuButtonView else {
                assertionFailure("failed to initialise neu button view")
                return
            }
            
            let highlightedObserver = observe(\UIButton.isHighlighted, options: .new) { [weak self] (button, change) in
                self?.neuButtonViewDataHolder?.neuButtonView?.toggleHighlightState(isHighlighted: change.newValue ?? false)
            }
            let enabledObserver = observe(\UIButton.isEnabled, options: .new) { [weak self] (button, change) in
                self?.neuButtonViewDataHolder?.neuButtonView?.toggleEnabledState(isEnabled: change.newValue ?? false)
            }
            let boundsObserver = observe(\UIButton.bounds, options: .new) { [weak self] (view, change) in
                self?.neuButtonViewDataHolder?.neuButtonView?.resizeContentView(to: change.newValue ?? .zero)
            }
            neuButtonViewDataHolder = NeuButtonViewDataHolder(neuButtonView: neuButtonViewT, highlightedObserver: highlightedObserver, enabledObserver: enabledObserver, boundsObserver: boundsObserver)
        }
    }
}

fileprivate extension UIButton {
    private struct AssociatedKeys {
        static var neuButtonViewDataHolderAssociationKey: UInt8 = 1
    }

    var neuButtonViewDataHolder: NeuButtonViewDataHolder? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.neuButtonViewDataHolderAssociationKey) as? NeuButtonViewDataHolder }
        set { objc_setAssociatedObject(self, &AssociatedKeys.neuButtonViewDataHolderAssociationKey, newValue, .OBJC_ASSOCIATION_COPY) }
    }
}

fileprivate class NeuButtonViewDataHolder: NSObject, NSCopying {

    var neuButtonView: NeuButtonView?
    var highlightedObserver: NSKeyValueObservation?
    var enabledObserver: NSKeyValueObservation?
    var boundsObserver: NSKeyValueObservation?

    required init(neuButtonView: NeuButtonView, highlightedObserver: NSKeyValueObservation, enabledObserver: NSKeyValueObservation, boundsObserver: NSKeyValueObservation) {
        self.neuButtonView = neuButtonView
        self.highlightedObserver = highlightedObserver
        self.enabledObserver = enabledObserver
        self.boundsObserver = boundsObserver
    }

    required init(_ objectToCopy: NeuButtonViewDataHolder) {
        self.neuButtonView = objectToCopy.neuButtonView
        self.highlightedObserver = objectToCopy.highlightedObserver
        self.enabledObserver = objectToCopy.enabledObserver
        self.boundsObserver = objectToCopy.boundsObserver
    }

    func copy(with zone: NSZone? = nil) -> Any {
        return type(of: self).init(self)
    }
}

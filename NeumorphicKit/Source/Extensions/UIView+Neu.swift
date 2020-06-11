//
//  UIView+Neu.swift
//  NeumorphicKit
//
//  Created by Prashant Shrivastava on 12/06/20.
//  Copyright © 2020 CRED. All rights reserved.
//

import UIKit

public extension UIView {
    
    /// Adds a neumorphic view on UIView and moves it to background
    /// - Parameters:
    ///   - model: config model to create neumorphic view, if not passed as parameter, takes default style
    ///   - showOnlyShadows: applies only shadows along the borders if set to true, shadow colors are determined by model passed
    func applyNeuStyle(model: NeuConstants.NeuViewModel = NeuConstants.NeuViewModel(), showOnlyShadows: Bool = false) {

        layer.masksToBounds = false
        backgroundColor = .clear

        if neuViewDataHolder == nil {
            let neuView = NeuView(frame: bounds, cornerRadius: layer.cornerRadius, model: model, showOnlyShadows: showOnlyShadows)
            let boundsObserver = observe(\UIView.bounds, options: .new) { [weak self] (view, change) in
                self?.neuViewDataHolder?.neuView?.resizeContentView(to: change.newValue ?? CGRect.zero)
            }
            neuViewDataHolder = NeuViewDataHolder(neuView: neuView, boundsObserver: boundsObserver)
        }

        if let neuView = neuViewDataHolder?.neuView, !neuView.isDescendant(of: self) {
            addSubview(neuView)
            if showOnlyShadows {
                bringSubviewToFront(neuView)
            } else {
                sendSubviewToBack(neuView)
            }
        }
    }
    
    /// returns UIImage which is blurred snapshot of view's current state
    func getNeuBlurredImage() -> UIImage? {
        guard let neuView = neuViewDataHolder?.neuView else {
            return nil
        }

        return neuView.getBlurredImage()
    }
}

extension UIView {
    private struct AssociatedKeys {
        static var neuViewDataHolderAssociationKey: UInt8 = 0
    }

    fileprivate var neuViewDataHolder: NeuViewDataHolder? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.neuViewDataHolderAssociationKey) as? NeuViewDataHolder }
        set { objc_setAssociatedObject(self, &AssociatedKeys.neuViewDataHolderAssociationKey, newValue, .OBJC_ASSOCIATION_COPY) }
    }
}

private class NeuViewDataHolder: NSObject, NSCopying {

    var neuView: NeuView?
    var boundsObserver: NSKeyValueObservation?

    required init(neuView: NeuView, boundsObserver: NSKeyValueObservation) {
        self.neuView = neuView
        self.boundsObserver = boundsObserver
    }

    required init(_ objectToCopy: NeuViewDataHolder) {
        self.neuView = objectToCopy.neuView
        self.boundsObserver = objectToCopy.boundsObserver
    }

    func copy(with zone: NSZone? = nil) -> Any {
        return type(of: self).init(self)
    }
}

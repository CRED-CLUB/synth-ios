//
//  NeuUIHelper.swift
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

public struct NeuUIHelper {
    
    /// Creates a border gradient layer
    /// - Parameters:
    ///   - gradientModel: Contains light direction, colors and border width to create layer
    ///   - bounds: bounds along which this layer is created
    ///   - cornerRadius: radius applied to all corners when creating layer
    ///
    /// - returns: CAGradientLayer object with border
    static func borderGradientLayer(gradientModel: NeuConstants.BorderGradientLayerModel, bounds: CGRect, cornerRadius: CGFloat) -> CAGradientLayer {

        let (startPoint, endPoint) = getGradientDirection(lightDirection: gradientModel.lightDirection)
        let colors = gradientModel.colors, borderWidth = gradientModel.borderWidth

        let curvedPath = UIBezierPath()
        if cornerRadius > 0 {
            curvedPath.move(to: CGPoint(x: cornerRadius, y: 0))
            curvedPath.addLine(to: CGPoint(x: bounds.width - cornerRadius, y: 0))

            if bounds.height > cornerRadius * 2 {
                curvedPath.addArc(withCenter: CGPoint(x: bounds.width - cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: -CGFloat.pi/2, endAngle: 0, clockwise: true)
                curvedPath.addLine(to: CGPoint(x: bounds.width, y: bounds.height - cornerRadius * 2))
                curvedPath.addArc(withCenter: CGPoint(x: bounds.width - cornerRadius, y: bounds.height - cornerRadius), radius: cornerRadius, startAngle: 0, endAngle: CGFloat.pi/2, clockwise: true)
            } else {
                curvedPath.addArc(withCenter: CGPoint(x: bounds.width - cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: -CGFloat.pi/2, endAngle: CGFloat.pi/2, clockwise: true)
            }

            curvedPath.addLine(to: CGPoint(x: cornerRadius, y: bounds.height))
            curvedPath.addArc(withCenter: CGPoint(x: cornerRadius, y: bounds.height - cornerRadius), radius: cornerRadius, startAngle: CGFloat.pi/2, endAngle: CGFloat.pi, clockwise: true)
            curvedPath.addLine(to: CGPoint(x: 0, y: cornerRadius))
            curvedPath.addArc(withCenter: CGPoint(x: cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: CGFloat.pi, endAngle: (3 * CGFloat.pi)/2, clockwise: true)
        } else {
            curvedPath.move(to: .zero)
            curvedPath.addLine(to: CGPoint(x: bounds.width, y: 0))
            curvedPath.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
            curvedPath.addLine(to: CGPoint(x: 0, y: bounds.height))
            curvedPath.addLine(to: .zero)
        }

        var transform = CGAffineTransform(translationX: borderWidth/2.0, y: borderWidth / 2.0)
        transform = transform.scaledBy(x: (bounds.width - borderWidth) / bounds.width,
                                       y: (bounds.height - borderWidth) / bounds.height)
        let cgPath = curvedPath.cgPath.copy(using: &transform)

        let borderShapeLayer = CAShapeLayer()
        borderShapeLayer.lineWidth = borderWidth
        borderShapeLayer.path = cgPath
        borderShapeLayer.fillColor = nil
        borderShapeLayer.strokeColor = UIColor.black.cgColor
        borderShapeLayer.lineCap = .round

        let borderGradientLayer = CAGradientLayer()
        borderGradientLayer.frame = bounds
        borderGradientLayer.startPoint = startPoint
        borderGradientLayer.endPoint = endPoint
        borderGradientLayer.colors = colors
        borderGradientLayer.masksToBounds = true
        borderGradientLayer.mask = borderShapeLayer
        return borderGradientLayer
    }
    
    public static func getDebossModel(baseColor: UIColor = NeuUtils.baseColor) -> NeuConstants.NeuViewModel {
        var neuModel = NeuConstants.NeuViewModel(baseColor: baseColor, isRectangle: true)
        neuModel.blurAmount = 0
        neuModel.borderGradientColors = [UIColor.clear.cgColor, UIColor.clear.cgColor]
        neuModel.shadowType = .outer
        neuModel.borderGradientWidth = 10.0
        neuModel.lightShadowModel = NeuConstants.NeuShadowModel(xOffset: 0, yOffset: 4, blur: 7, spread: 0, color: UIColor.black, opacity: 0.4)
        neuModel.darkShadowModel = NeuConstants.NeuShadowModel(xOffset: -2, yOffset: -2, blur: 6, spread: 0, color: UIColor.white.withAlphaComponent(0.2), opacity: 0.4)
        return neuModel
    }
    
    /// Remove subviews from a view
    static func removeAllSubViews(view: UIView) {
        if view.subviews.count > 0 {
            for subView: AnyObject in view.subviews {
                subView.removeFromSuperview()
            }
        }
    }
    
    /// Remove all sublayers from a view
    static func removeAllSublayers(view: UIView) {
        view.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
    }
    
    /// Gets gradient start and end point  from given light direction
    static func getGradientDirection(lightDirection: NeuConstants.NeuLightDirection) -> (CGPoint, CGPoint) {

        var startPoint: CGPoint = .zero
        var endPoint: CGPoint = .zero
        switch lightDirection {
        case .left:
            endPoint = CGPoint(x: 1, y: 0)
        case .topLeft:
            endPoint = CGPoint(x: 1, y: 1)
        case .top:
            endPoint = CGPoint(x: 0, y: 1)
        case .topRight:
            startPoint = CGPoint(x: 1, y: 0)
            endPoint = CGPoint(x: 0, y: 1)
        case .right:
            startPoint = CGPoint(x: 1, y: 0)
            endPoint = .zero
        case .bottomRight:
            startPoint = CGPoint(x: 1, y: 0)
            endPoint = .zero
        case .bottom:
            startPoint = CGPoint(x: 0, y: 1)
            endPoint = .zero
        case .bottomLeft:
            startPoint = CGPoint(x: 0, y: 1)
            endPoint = CGPoint(x: 1, y: 0)
        case .base:
            endPoint = CGPoint(x: 1, y: 1)
        }
        return (startPoint, endPoint)
    }
}

//
//  CALayer+Shadow.swift
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

extension CALayer {

    func applyShadow(color: UIColor = .white,
                           alpha: Float = 0.5,
                           x: CGFloat = 0,
                           y: CGFloat = 2,
                           blur: CGFloat = 4,
                           spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0

        if spread == 0 {
            shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath
        }
    }

    func addInnerShadow(shadowColor: UIColor, shadowOpacity: Float, blur: CGFloat, xOffset: CGFloat, yOffset: CGFloat) {

        guard (abs(xOffset) > 0 || abs(yOffset) > 0) && blur > 0 else { return }

        let shadowLayer = CAShapeLayer()
        shadowLayer.frame = bounds.insetBy(dx: -1, dy: -1)
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.shadowOffset = .zero
        shadowLayer.shadowOpacity = shadowOpacity
        shadowLayer.shadowRadius = blur
        shadowLayer.fillRule = .evenOdd

        let invertedX = -xOffset
        let invertedY = -yOffset
        let insetRect = shadowLayer.bounds
        let path = UIBezierPath(roundedRect: insetRect, cornerRadius: cornerRadius)
        path.append(getShadowPath(xOffset: invertedX, yOffset: invertedY, bounds: shadowLayer.bounds, cornerRadius: cornerRadius))

        shadowLayer.path = path.cgPath
        addSublayer(shadowLayer)

        masksToBounds = true
    }

    func addSkewedGradientLayer(colors: [CGColor]) {

        let containerLayer = CALayer()  // don't want to interfere with current layer's configuration so container layer is created with masksToBounds true
        containerLayer.frame = bounds
        containerLayer.cornerRadius = cornerRadius
        containerLayer.masksToBounds = true

        defer { addSublayer(containerLayer) }
        guard colors.count >= 2 else {
            containerLayer.backgroundColor = colors.first
            return
        }

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = cornerRadius

        let hypotenuse = sqrt(pow(frame.size.width, 2) + pow(frame.size.height, 2))
        // area of square = height * width = hypotenuse * (maximum distance length perpendicular to hypotenuse)
        let heightOfGradient = (frame.size.width * frame.size.height * 2) / hypotenuse
        let angleInRadians = atan(frame.size.height/frame.size.width)

        let newBounds = CGRect(x: 0, y: 0, width: hypotenuse, height: heightOfGradient)
        gradientLayer.bounds = newBounds
        gradientLayer.setAffineTransform(CGAffineTransform(rotationAngle: -angleInRadians))
        containerLayer.addSublayer(gradientLayer)
    }
    
    private func getShadowPath(xOffset: CGFloat, yOffset: CGFloat, bounds: CGRect, cornerRadius: CGFloat) -> UIBezierPath {

        let absX = abs(xOffset), absY = abs(yOffset)
        let minX = xOffset < 0 ? xOffset : 0
        let minY = yOffset < 0 ? yOffset : 0
        let maxX = xOffset < 0 ? bounds.width : (bounds.width + absX)
        let maxY = yOffset < 0 ? bounds.height : (bounds.height + absY)
        let (topLeftRadius, topRightRadius, bottomRightRadius, bottomLeftRadius) = getShadowPathRadius(xOffset: xOffset, yOffset: yOffset, cornerRadius: cornerRadius)
        let shadowPath = UIBezierPath()
        shadowPath.move(to: CGPoint(x: minX + topLeftRadius, y: minY))
        shadowPath.addLine(to: CGPoint(x: maxX - topRightRadius, y: minY))
        shadowPath.addArc(withCenter: CGPoint(x: maxX - topRightRadius, y: minY + topRightRadius), radius: topRightRadius, startAngle: CGFloat((3 * Double.pi) / 2), endAngle: 0, clockwise: true)
        shadowPath.addLine(to: CGPoint(x: maxX, y: maxY - bottomRightRadius))
        shadowPath.addArc(withCenter: CGPoint(x: maxX - bottomRightRadius, y: maxY - bottomRightRadius), radius: bottomRightRadius, startAngle: 0, endAngle: CGFloat(Double.pi/2), clockwise: true)
        shadowPath.addLine(to: CGPoint(x: minX + bottomLeftRadius, y: maxY))
        shadowPath.addArc(withCenter: CGPoint(x: minX + bottomLeftRadius, y: maxY - bottomLeftRadius), radius: bottomLeftRadius, startAngle: CGFloat(Double.pi/2), endAngle: CGFloat(Double.pi), clockwise: true)
        shadowPath.addLine(to: CGPoint(x: minX, y: minY + topLeftRadius))
        shadowPath.addArc(withCenter: CGPoint(x: minX + topLeftRadius, y: minY + topLeftRadius), radius: topLeftRadius, startAngle: CGFloat(Double.pi), endAngle: CGFloat((3 * Double.pi) / 2), clockwise: true)
        shadowPath.close()
        return shadowPath
    }

    private func getShadowPathRadius(xOffset: CGFloat, yOffset: CGFloat, cornerRadius: CGFloat) -> (topLeftRadius: CGFloat, topRightRadius: CGFloat, bottomRightRadius: CGFloat, bottomLeftRadius: CGFloat) {

        var topLeftRadius: CGFloat = cornerRadius, topRightRadius: CGFloat = cornerRadius, bottomRightRadius: CGFloat = cornerRadius, bottomLeftRadius: CGFloat = cornerRadius
        guard xOffset != 0 || yOffset != 0 else {
            return (topLeftRadius, topRightRadius, bottomRightRadius, bottomLeftRadius)
        }

        let maxCornerRadiusX = cornerRadius + abs(xOffset)
        let maxCornerRadiusY = cornerRadius + abs(yOffset)

        if xOffset < 0 && yOffset == 0 {
            topLeftRadius = maxCornerRadiusX
            bottomLeftRadius = maxCornerRadiusX
        } else if xOffset == 0 && yOffset < 0 {
            topLeftRadius = maxCornerRadiusY
            topRightRadius = maxCornerRadiusY
        } else if xOffset > 0 && yOffset == 0 {
            topRightRadius = maxCornerRadiusX
            bottomRightRadius = maxCornerRadiusX
        } else if xOffset == 0 && yOffset > 0  {
            bottomRightRadius = maxCornerRadiusY
            bottomLeftRadius = maxCornerRadiusY
        } else if xOffset < 0 && yOffset < 0 {
            bottomLeftRadius = maxCornerRadiusX
            topLeftRadius = maxCornerRadiusX
            topRightRadius = maxCornerRadiusY
        } else if xOffset > 0 && yOffset < 0 {
            topLeftRadius = maxCornerRadiusY
            topRightRadius = maxCornerRadiusY
            bottomRightRadius = maxCornerRadiusX
        } else if xOffset > 0 && yOffset > 0 {
            topRightRadius = maxCornerRadiusX
            bottomRightRadius = maxCornerRadiusX
            bottomLeftRadius = maxCornerRadiusY
        } else {
            bottomRightRadius = maxCornerRadiusY
            bottomLeftRadius = maxCornerRadiusX
            topLeftRadius = maxCornerRadiusX
        }
        return (topLeftRadius, topRightRadius, bottomRightRadius, bottomLeftRadius)
    }
}

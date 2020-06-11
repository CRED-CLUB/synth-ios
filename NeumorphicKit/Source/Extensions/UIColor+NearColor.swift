//
//  UIColor.swift
//  NeumorphicKit
//
//  Created by Prashant Shrivastava on 12/06/20.
//  Copyright © 2020 CRED. All rights reserved.
//

import UIKit

extension UIColor {
    
    func lighten(fraction: CGFloat) -> UIColor {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        red = lightenColor(color: red, fraction: fraction)
        green = lightenColor(color: green, fraction: fraction)
        blue = lightenColor(color: blue, fraction: fraction)
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

    func darken(fraction: CGFloat) -> UIColor {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        red = darkenColor(color: red, fraction: fraction)
        green = darkenColor(color: green, fraction: fraction)
        blue = darkenColor(color: blue, fraction: fraction)
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    private func lightenColor(color: CGFloat, fraction: CGFloat) -> CGFloat {
        return min(color + (1 - color) * fraction, 1)
    }

    private func darkenColor(color: CGFloat, fraction: CGFloat) -> CGFloat {
        return max(color - color * fraction, 0)
    }
}

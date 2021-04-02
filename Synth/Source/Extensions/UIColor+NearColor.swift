//
//  UIColor.swift
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

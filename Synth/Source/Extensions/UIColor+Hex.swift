//
//  UIColor+Hex.swift
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
    
    static func fromHex(_ hex: String, alpha opacity: CGFloat? = nil) -> UIColor {
        let colorCode = hex.suffix(6)
        let hexint = Int(intFromHexString(hexStr: String(colorCode)))
        let red: CGFloat = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green: CGFloat = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue: CGFloat = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha: CGFloat
        if hex.count >= 8 {
            let alphaCode = hex.suffix(8).prefix(2)
            let alphaHexInt = Int(intFromHexString(hexStr: String(alphaCode)))
            alpha = opacity ?? CGFloat(alphaHexInt & 0xff) / 255.0
        } else {
            alpha = opacity ?? 1.0
        }
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

    private static func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        let scanner: Scanner = Scanner(string: hexStr)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
}

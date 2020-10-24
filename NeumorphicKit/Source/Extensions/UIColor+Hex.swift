//
//  UIColor+Hex.swift
//  NeumorphicKit
//
//  Created by Prashant Shrivastava on 24/10/20.
//  Copyright © 2020 CRED. All rights reserved.
//

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

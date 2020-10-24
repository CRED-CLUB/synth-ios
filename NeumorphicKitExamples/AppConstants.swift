//
//  AppConstants.swift
//  NeumorphicKitExamples
//
//  Created by Prashant Shrivastava on 24/10/20.
//  Copyright © 2020 CRED. All rights reserved.
//

import UIKit

struct AppConstants {
    
    static let baseColor = UIColor(red: 33.0/255.0, green: 36.0/255.0, blue: 38.0/255.0, alpha: 1.0)
    static let textColor = UIColor(red: 249.0/255.0, green: 211.0/255.0, blue: 180.0/255.0, alpha: 1.0)
    
    static func getBorderedAttributedText(with text: String) -> NSAttributedString {
        
        let strokeColor = UIColor(red: 249.0/255.0, green: 211.0/255.0, blue: 180.0/255.0, alpha: 1.0)
        let textAttributes: [NSAttributedString.Key:Any] = [
            .strokeColor: strokeColor,
            .foregroundColor: UIColor.clear,
            .strokeWidth: -2.0,
            .font: UIFont.boldSystemFont(ofSize: 50)
        ]
        return NSAttributedString(string: text, attributes: textAttributes)
    }
}

//
//  ViewController.swift
//  NeumorphicKitExamples
//
//  Created by Prashant Shrivastava on 12/06/20.
//  Copyright © 2020 CRED. All rights reserved.
//

import UIKit
import NeumorphicKit

class ViewController: UIViewController {

    @IBOutlet weak var neumorphicView: UIView!
    @IBOutlet weak var neumorphicSoftButton: UIButton!
    @IBOutlet weak var neumorphicRoundButton: UIButton!
    @IBOutlet weak var neumorphicFlatButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = NeuUtils.baseColor
        setupTextAttributes()
        
        neumorphicView.layer.cornerRadius = 20
        neumorphicView.applyNeuStyle()
        
        neumorphicSoftButton.applyNeuBtnStyle(type: .elevatedSoft, title: "Soft Button")
        neumorphicRoundButton.applyNeuBtnStyle(type: .elevatedSoftRound, image: UIImage(named: "back"), imageDimension: 15)
        neumorphicFlatButton.applyNeuBtnStyle(type: .elevatedFlat, title: "Flat Button")
    }
    
    private func setupTextAttributes() {
        
        var attributes: [NSAttributedString.Key:Any] = [:]
        attributes[.foregroundColor] = UIColor.white
        attributes[.font] = UIFont.systemFont(ofSize: 15)
        
        NeuUtils.textAttributes = attributes
    }
}


//
//  ButtonsViewController.swift
//  NeumorphicKitExamples
//
//  Created by Prashant Shrivastava on 24/10/20.
//  Copyright © 2020 CRED. All rights reserved.
//

import UIKit
import NeumorphicKit

class ButtonsViewController: UIViewController {
    
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var elevatedSoftWithImageButton: UIButton!
    @IBOutlet weak var elevatedSoftButton: UIButton!
    @IBOutlet weak var elevatedSoftRoundButton: UIButton!
    @IBOutlet weak var elevatedFlatButton: UIButton!
    @IBOutlet weak var elevatedFlatRoundButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        
        view.backgroundColor = NeuUtils.baseColor
        contentScrollView.delaysContentTouches = false
        
        setupBackButton()
        
        let textColor = UIColor(red: 249.0/255.0, green: 211.0/255.0, blue: 180.0/255.0, alpha: 0.9)
        let textAttributes: [NSAttributedString.Key:Any] = [
            .foregroundColor: textColor,
            .kern: 0.65,
            .font: UIFont.systemFont(ofSize: 14, weight: .semibold)
        ]
        elevatedSoftWithImageButton.applyNeuBtnStyle(type: .elevatedSoft, attributedTitle: NSAttributedString(string: "Idle now", attributes: textAttributes), image: UIImage(named: "plus"), imageDimension: 10)
        elevatedSoftButton.applyNeuBtnStyle(type: .elevatedSoft, attributedTitle: NSAttributedString(string: "Idle now", attributes: textAttributes))
        
        elevatedSoftRoundButton.applyNeuBtnStyle(type: .elevatedSoftRound, image: UIImage(named: "back"), imageDimension: 18)
        
        let flatTextAttributes: [NSAttributedString.Key:Any] = [
            .foregroundColor: UIColor.white.withAlphaComponent(0.9),
            .kern: 0.54,
            .font: UIFont.systemFont(ofSize: 14, weight: .semibold)
        ]
        elevatedFlatButton.applyNeuBtnStyle(type: .elevatedFlat, attributedTitle: NSAttributedString(string: "Idle now", attributes: flatTextAttributes))
        
        elevatedFlatRoundButton.applyNeuBtnStyle(type: .elevatedFlatRound, attributedTitle: NSAttributedString(string: "Spin", attributes: textAttributes))
    }
    
    private func setupBackButton() {
        
        backButton.backgroundColor = UIColor(red: 81.0/255.0, green: 79.0/255.0, blue: 79.0/255.0, alpha: 0.23)
        backButton.layer.cornerRadius = backButton.bounds.height/2
        backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
    }
    
    @objc private func backButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
}

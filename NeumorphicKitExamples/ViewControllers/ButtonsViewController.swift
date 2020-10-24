//
//  ButtonsViewController.swift
//  NeumorphicKitExamples
//
//  Created by Prashant Shrivastava on 24/10/20.
//  Copyright © 2020 CRED. All rights reserved.
//

import UIKit

class ButtonsViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var dotView: UIView!
    @IBOutlet weak var elevatedSoftLabel: UILabel!
    @IBOutlet weak var elevatedSoftView: UIView!
    @IBOutlet weak var elevatedSoftWithImageButton: UIButton!
    @IBOutlet weak var elevatedSoftButton: UIButton!
    @IBOutlet weak var elevatedSoftRoundLabel: UILabel!
    @IBOutlet weak var elevatedSoftRoundView: UIView!
    @IBOutlet weak var elevatedSoftRoundButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        
        view.backgroundColor = AppConstants.baseColor
        
        titleLabel.attributedText = AppConstants.getBorderedAttributedText(with: "buttons")
        lineView.backgroundColor = UIColor(red: 178.0/255.0, green: 134.0/255.0, blue: 99.0/255.0, alpha: 0.2)
        
        setupBackButton()
        setupDotView()
        
        updateView(view: elevatedSoftView, label: elevatedSoftLabel, with: "ELEVATED SOFT")
        
        let textAttributes: [NSAttributedString.Key:Any] = [
            .foregroundColor: AppConstants.textColor.withAlphaComponent(0.9),
            .kern: 0.65,
            .font: UIFont.systemFont(ofSize: 14, weight: .semibold)
        ]
        elevatedSoftWithImageButton.applyNeuBtnStyle(type: .elevatedSoft, attributedTitle: NSAttributedString(string: "Idle now", attributes: textAttributes), image: UIImage(named: "plus"), imageDimension: 10)
        elevatedSoftButton.applyNeuBtnStyle(type: .elevatedSoft, attributedTitle: NSAttributedString(string: "Idle now", attributes: textAttributes))
        
        updateView(view: elevatedSoftRoundView, label: elevatedSoftRoundLabel, with: "ELEVATED SOFT ROUND")
        elevatedSoftRoundButton.applyNeuBtnStyle(type: .elevatedSoftRound, image: UIImage(named: "back"), imageDimension: 18)
    }
    
    private func setupBackButton() {
        
        backButton.backgroundColor = UIColor(red: 81.0/255.0, green: 79.0/255.0, blue: 79.0/255.0, alpha: 0.23)
        backButton.layer.cornerRadius = backButton.bounds.height/2
        backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
    }
    
    private func setupDotView() {
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [UIColor(red: 251.0/255.0, green: 195.0/255.0, blue: 150.0/255.0, alpha: 1.0).cgColor, UIColor(red: 99.0/255.0, green: 69.0/255.0, blue: 44.0/255.0, alpha: 1.0).cgColor]
        gradient.startPoint = .zero
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = dotView.bounds

        dotView.layer.insertSublayer(gradient, at: 0)
        dotView.layer.cornerRadius = dotView.bounds.height/2
        dotView.layer.masksToBounds = true
    }
    
    private func updateView(view: UIView, label: UILabel, with text: String) {
        
        let textAttributes: [NSAttributedString.Key:Any] = [
            .foregroundColor: UIColor.white.withAlphaComponent(0.5),
            .kern: 4,
            .font: UIFont.systemFont(ofSize: 10, weight: .medium)
        ]
        label.attributedText = NSAttributedString(string: text, attributes: textAttributes)
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
    }
    
    @objc private func backButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
}

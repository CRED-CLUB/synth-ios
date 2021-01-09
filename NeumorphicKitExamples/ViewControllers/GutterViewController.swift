//
//  GutterViewController.swift
//  NeumorphicKitExamples
//
//  Created by Prashant Shrivastava on 17/12/20.
//  Copyright © 2020 CRED. All rights reserved.
//

import UIKit
import NeumorphicKit

class GutterViewController: UIViewController {
    
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var gutterContainerView: UIView!
    @IBOutlet weak var embossView: UIView!
    @IBOutlet weak var debossView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        
        view.backgroundColor = NeuUtils.baseColor
        contentScrollView.delaysContentTouches = false
        
        setupBackButton()
        
        gutterContainerView.layer.cornerRadius = 25
        gutterContainerView.layer.borderColor = UIColor(red: 249.0/255.0, green: 211.0/255.0, blue: 180.0/255.0, alpha: 0.2).cgColor
        gutterContainerView.layer.borderWidth = 0.5
        
        embossView.layer.cornerRadius = 14
        embossView.applyNeuStyle()
        
        debossView.layer.cornerRadius = 14
        debossView.applyNeuStyle(model: NeuUIHelper.getDebossModel())
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

//
//  GutterViewController.swift
//  SynthExamples
//
//  Copyright 2020 Dreamplug Technologies Private Limited
//

import UIKit
import Synth

class GutterViewController: UIViewController {
    
    @IBOutlet weak var contentScrollView: UIScrollView!
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
                
        gutterContainerView.layer.cornerRadius = 25
        gutterContainerView.layer.borderColor = UIColor(red: 249.0/255.0, green: 211.0/255.0, blue: 180.0/255.0, alpha: 0.2).cgColor
        gutterContainerView.layer.borderWidth = 0.5
        
        embossView.layer.cornerRadius = 14
        embossView.applyNeuStyle()
        
        debossView.layer.cornerRadius = 14
        debossView.applyNeuStyle(model: NeuUIHelper.getDebossModel())
    }
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}

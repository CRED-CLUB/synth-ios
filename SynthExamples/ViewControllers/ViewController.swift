//
//  ViewController.swift
//  SynthExamples
//
//  Copyright 2020 Dreamplug Technologies Private Limited
//

import UIKit
import Synth

class ViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var buttonsImageView: UIImageView!
    @IBOutlet weak var gutterImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        view.backgroundColor = NeuUtils.baseColor
        
        containerView.layer.cornerRadius = 20
        containerView.applyNeuStyle()
        
        let buttonTapGesture = UITapGestureRecognizer(target: self, action: #selector(exploreButtonsClicked))
        buttonsImageView.addGestureRecognizer(buttonTapGesture)
        
        let gutterTapGesture = UITapGestureRecognizer(target: self, action: #selector(exploreGutterClicked))
        gutterImageView.addGestureRecognizer(gutterTapGesture)
    }
    
    @objc func exploreButtonsClicked() {
        let buttonsVC = ButtonsViewController(nibName: "ButtonsViewController", bundle: nil)
        navigationController?.pushViewController(buttonsVC, animated: true)
    }
    
    @objc func exploreGutterClicked() {
        let gutterVC = GutterViewController(nibName: "GutterViewController", bundle: nil)
        navigationController?.pushViewController(gutterVC, animated: true)
    }
}

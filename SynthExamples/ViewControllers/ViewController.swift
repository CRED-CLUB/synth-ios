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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        view.backgroundColor = NeuUtils.baseColor
        
        containerView.layer.cornerRadius = 20
        containerView.applyNeuStyle()
    }
    
    @IBAction func exploreButtonsClicked(_ sender: UIButton) {
        let buttonsVC = ButtonsViewController(nibName: "ButtonsViewController", bundle: nil)
        navigationController?.pushViewController(buttonsVC, animated: true)
    }
    
    @IBAction func exploreGutterClicked(_ sender: UIButton) {
        let gutterVC = GutterViewController(nibName: "GutterViewController", bundle: nil)
        navigationController?.pushViewController(gutterVC, animated: true)
    }
}

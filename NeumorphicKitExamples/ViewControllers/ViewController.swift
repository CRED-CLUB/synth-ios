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

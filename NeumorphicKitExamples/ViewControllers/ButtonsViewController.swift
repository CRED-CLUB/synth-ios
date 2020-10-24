//
//  ButtonsViewController.swift
//  NeumorphicKitExamples
//
//  Created by Prashant Shrivastava on 24/10/20.
//  Copyright © 2020 CRED. All rights reserved.
//

import UIKit

class ButtonsViewController: UIViewController {
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

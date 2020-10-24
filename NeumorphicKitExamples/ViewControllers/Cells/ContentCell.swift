//
//  ContentCell.swift
//  NeumorphicKitExamples
//
//  Created by Prashant Shrivastava on 24/10/20.
//  Copyright © 2020 CRED. All rights reserved.
//

import UIKit

class ContentCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = "ContentCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with text: String) {
        titleLabel.text = text
    }
}

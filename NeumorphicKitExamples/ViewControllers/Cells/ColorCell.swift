//
//  ColorCell.swift
//  NeumorphicKitExamples
//
//  Created by Prashant Shrivastava on 18/12/20.
//  Copyright © 2020 CRED. All rights reserved.
//

import UIKit

class ColorCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var colorView: UIView!
    
    static var identifier = "ColorCell"
    static var itemSize = CGSize(width: 46, height: 46)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    func configure(color: UIColor, isSelected: Bool) {
        colorView.backgroundColor = color
        bgView.isHidden = !isSelected
    }
    
    private func setupViews() {
        bgView.layer.cornerRadius = bgView.bounds.height/2
        bgView.applyNeuStyle()
        
        colorView.layer.cornerRadius = colorView.bounds.height/2
    }
}

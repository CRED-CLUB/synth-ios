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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var dotView: UIView!
    @IBOutlet weak var embossTitleLabel: UILabel!
    @IBOutlet weak var embossLineView: UIView!
    @IBOutlet weak var gutterContainerView: UIView!
    @IBOutlet weak var embossView: UIView!
    @IBOutlet weak var debossView: UIView!
    @IBOutlet weak var hexLabel: UILabel!
    @IBOutlet weak var hexTextfield: UITextField!
    @IBOutlet weak var hexTextLineView: UIView!
    @IBOutlet weak var colorsCollectionView: UICollectionView!
    
    private var colors: [UIColor] = [
        UIColor.fromHex("c17b5c", alpha: 0.9),
        UIColor.fromHex("847182", alpha: 0.4),
        UIColor.fromHex("5464b8", alpha: 0.4),
        UIColor.fromHex("3eaa88", alpha: 0.4),
        UIColor.fromHex("567173", alpha: 0.4),
    ]
    private var colorCellSpacing: CGFloat = 16
    private var selectedColorIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        
        view.backgroundColor = AppConstants.baseColor
        contentScrollView.delaysContentTouches = false
        
        titleLabel.attributedText = AppConstants.getBorderedAttributedText(with: "gutter")
        lineView.backgroundColor = UIColor(red: 178.0/255.0, green: 134.0/255.0, blue: 99.0/255.0, alpha: 0.2)
        
        setupBackButton()
        setupDotView()
        
        let textAttributes: [NSAttributedString.Key:Any] = [
            .foregroundColor: UIColor.white.withAlphaComponent(0.5),
            .kern: 4,
            .font: UIFont.systemFont(ofSize: 10, weight: .medium)
        ]
        embossTitleLabel.attributedText = NSAttributedString(string: "EMBOSS & DEBOSS", attributes: textAttributes)
        embossLineView.backgroundColor = UIColor.white.withAlphaComponent(0.5)

        gutterContainerView.layer.cornerRadius = 25
        gutterContainerView.layer.borderColor = UIColor(red: 249.0/255.0, green: 211.0/255.0, blue: 180.0/255.0, alpha: 0.2).cgColor
        gutterContainerView.layer.borderWidth = 0.5
        
        embossView.layer.cornerRadius = 14
        embossView.applyNeuStyle()
        
        debossView.layer.cornerRadius = 14
        debossView.applyNeuStyle()
        
        let hexTextAttributes: [NSAttributedString.Key:Any] = [
            .foregroundColor: UIColor.white.withAlphaComponent(0.5),
            .kern: 4,
            .font: UIFont.systemFont(ofSize: 10, weight: .medium)
        ]
        hexLabel.attributedText = NSAttributedString(string: "BACKGROUD COLOUR HEX CODE", attributes: hexTextAttributes)
        hexTextLineView.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        
        let hexTextFieldAttributes: [NSAttributedString.Key:Any] = [
            .foregroundColor: UIColor(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 0.8),
            .kern: 1.2,
            .font: UIFont.systemFont(ofSize: 30, weight: .bold)
        ]
        hexTextfield.typingAttributes = hexTextFieldAttributes
        hexTextfield.attributedText = NSAttributedString(string: "# 212426", attributes: hexTextFieldAttributes)
        
        colorsCollectionView.delegate = self
        colorsCollectionView.dataSource = self
        colorsCollectionView.register(UINib(nibName: ColorCell.identifier, bundle: nil), forCellWithReuseIdentifier: ColorCell.identifier)
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

extension GutterViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return colorCellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return ColorCell.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let screenWidth = UIScreen.main.bounds.width
        let itemsWidth = ColorCell.itemSize.width * CGFloat(colors.count) + colorCellSpacing * CGFloat(colors.count - 1)
        let horizontalInset = (screenWidth - itemsWidth)/2
        return UIEdgeInsets(top: 0, left: horizontalInset, bottom: 0, right: horizontalInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedColorIndex = indexPath.item
        colorsCollectionView.reloadData()
        
        embossView.applyNeuStyle(model: NeuConstants.NeuViewModel(baseColor: colors[indexPath.item]))
    }
}

extension GutterViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.identifier, for: indexPath)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.identifier, for: indexPath) as? ColorCell else {
            return UICollectionViewCell(frame: .zero)
        }
        cell.configure(color: colors[indexPath.item], isSelected: indexPath.item == selectedColorIndex)
        return cell
    }
}

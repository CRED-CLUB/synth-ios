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
    @IBOutlet weak var collectionBottomConstraint: NSLayoutConstraint!
    
    private var hexPrefixLabel: UILabel?

    private var hexColors = [
        "c17b5c",
        "847182",
        "5464b8",
        "3eaa88",
        "567173",
    ]
    private var colorCellSpacing: CGFloat = 16
    private var selectedColorIndex = -1
    private var initialBottomConstant: CGFloat = 50

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
        debossView.applyNeuStyle(model: NeuUIHelper.getDebossModel())
        
        let hexTextAttributes: [NSAttributedString.Key:Any] = [
            .foregroundColor: UIColor.white.withAlphaComponent(0.5),
            .kern: 4,
            .font: UIFont.systemFont(ofSize: 10, weight: .medium)
        ]
        hexLabel.attributedText = NSAttributedString(string: "BACKGROUD COLOUR HEX CODE", attributes: hexTextAttributes)
        hexTextLineView.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        
        hexPrefixLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: hexTextfield.bounds.height))
        hexPrefixLabel?.attributedText = NSAttributedString(string: "# ", attributes: getTextfieldAttributes())
        
        hexTextfield.typingAttributes = getTextfieldAttributes()
        hexTextfield.attributedText = NSAttributedString(string: "212426", attributes: getTextfieldAttributes())
        hexTextfield.delegate = self
        hexTextfield.returnKeyType = .done
        hexTextfield.leftView = hexPrefixLabel
        hexTextfield.leftViewMode = .always
        
        colorsCollectionView.delegate = self
        colorsCollectionView.dataSource = self
        colorsCollectionView.register(UINib(nibName: ColorCell.identifier, bundle: nil), forCellWithReuseIdentifier: ColorCell.identifier)
        
        collectionBottomConstraint.constant = initialBottomConstant
        registerNotifications()
    }
    
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        
        guard let userInfo = notification.userInfo, let rect = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect else { return }
        collectionBottomConstraint.constant = rect.size.height
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        } completion: { success in
            self.contentScrollView.setContentOffset(CGPoint(x: 0, y: self.contentScrollView.contentSize.height - self.contentScrollView.bounds.height), animated: true)
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        collectionBottomConstraint.constant = initialBottomConstant
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
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
    
    private func getTextfieldAttributes() -> [NSAttributedString.Key:Any] {
        return [
            .foregroundColor: UIColor(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 0.8),
            .kern: 1.2,
            .font: UIFont.systemFont(ofSize: 30, weight: .bold)
        ]
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
        let itemsWidth = ColorCell.itemSize.width * CGFloat(hexColors.count) + colorCellSpacing * CGFloat(hexColors.count - 1)
        let horizontalInset = (screenWidth - itemsWidth)/2
        return UIEdgeInsets(top: 0, left: horizontalInset, bottom: 0, right: horizontalInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedColorIndex = indexPath.item
        colorsCollectionView.reloadData()
        hexTextfield.resignFirstResponder()
        
        embossView.applyNeuStyle(model: NeuConstants.NeuViewModel(baseColor: UIColor.fromHex(hexColors[indexPath.item])))
        debossView.applyNeuStyle(model: NeuUIHelper.getDebossModel(baseColor: UIColor.fromHex(hexColors[indexPath.item])))
    }
}

extension GutterViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hexColors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.identifier, for: indexPath)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.identifier, for: indexPath) as? ColorCell else {
            return UICollectionViewCell(frame: .zero)
        }
        cell.configure(hexColor: hexColors[indexPath.item], isSelected: indexPath.item == selectedColorIndex)
        return cell
    }
}

extension GutterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard !string.isEmpty else { return true }
        guard let text = textField.attributedText?.string, let textRange = Range(range, in: text) else { return true }
        
        let newText = text.replacingCharacters(in: textRange, with: string)
        
        guard newText.count <= 6 else { return false }
        
        hexTextfield.attributedText = NSAttributedString(string: newText, attributes: getTextfieldAttributes())
        return false
    }
}

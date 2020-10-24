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

    @IBOutlet weak var tableView: UITableView!
    
    private let items = [
        "buttons",
        "gutter emboss",
        "gutter deboss"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        setupTableView()
    }
    
    private func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: ContentCell.identifier, bundle: nil), forCellReuseIdentifier: ContentCell.identifier)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentCell.identifier, for: indexPath) as? ContentCell else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "UITableViewCell")
            return cell
        }
        
        cell.configure(with: items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let buttonsVC = ButtonsViewController(nibName: "ButtonsViewController", bundle: nil)
            navigationController?.pushViewController(buttonsVC, animated: true)
        default:
            break
        }
    }
}


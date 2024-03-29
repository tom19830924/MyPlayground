//
//  RootDummyViewController.swift
//  Rotation
//
//  Created by user on 2024/3/28.
//

import UIKit

class RootDummyViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let label = UILabel(frame: .zero)
        label.text = "Dummy"
        label.textColor = .red
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    override var shouldAutorotate: Bool {
        true
    }
}

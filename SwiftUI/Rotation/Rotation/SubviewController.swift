//
//  SubviewController.swift
//  Rotation
//
//  Created by user on 2024/3/28.
//

import UIKit

class SubviewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        let label = UILabel(frame: .zero)
        label.text = "Label"
        label.textColor = .red
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let btn = UIButton(type: .system)
        btn.setTitle("Button", for: .normal)
        btn.addTarget(self, action: #selector(test), for: .touchUpInside)
        view.addSubview(btn)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        btn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
    }
    
    @objc func test() {
        dismiss(animated: true)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        UIInterfaceOrientationMask.landscape
    }
}

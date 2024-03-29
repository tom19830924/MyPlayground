//
//  ViewController.swift
//  Rotation
//
//  Created by user on 2024/3/28.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let btn = UIButton(type: .system)
        btn.setTitle("Button", for: .normal)
        btn.addTarget(self, action: #selector(test), for: .touchUpInside)
        view.addSubview(btn)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }

    @objc func test() {
        let vc = SubviewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}


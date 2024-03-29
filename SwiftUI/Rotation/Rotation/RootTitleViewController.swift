//
//  RootTitleViewController.swift
//  Rotation
//
//  Created by user on 2024/3/28.
//

import UIKit

class RootTitleViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel(frame: .zero)
        label.text = "Title"
        label.textColor = .red
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Push", style: .plain, target: self, action: #selector(test))
    }
    
    @objc func test() {
        let vc = ViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
}

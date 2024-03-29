//
//  MainTabController.swift
//  Rotation
//
//  Created by user on 2024/3/28.
//

import UIKit

class MainTabController: UITabBarController {
    let vc1 = RootTitleViewController()
    let vc2 = RootDummyViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nav = MyNavigationController(rootViewController: vc1)
        vc1.title = "Title"
        
        
        vc2.title = "Dummy"
        
        self.setViewControllers([nav, vc2], animated: false)
    }
    
    override var shouldAutorotate: Bool {
        return self.selectedViewController?.shouldAutorotate ?? true
        
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return self.selectedViewController?.supportedInterfaceOrientations ?? .allButUpsideDown
    }
}

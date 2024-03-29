//
//  MyNavigationController.swift
//  Rotation
//
//  Created by user on 2024/3/28.
//

import UIKit

class MyNavigationController: UINavigationController {
    override var shouldAutorotate: Bool {
        return self.topViewController?.shouldAutorotate ?? true
        
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return self.topViewController?.supportedInterfaceOrientations ?? .allButUpsideDown
    }
}

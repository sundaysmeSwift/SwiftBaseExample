//
//  SQBaseNavigationController.swift
//  SwiftBaseExample
//
//  Created by administrator on 2019/5/26.
//  Copyright © 2019 administrator. All rights reserved.
//

import Foundation
import UIKit

class SQBaseNavigationController: UINavigationController {
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count == 1 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }
    // 返回最上层的子Controller的shouldAutorotate
    override var shouldAutorotate: Bool{
        get {
            return self.topViewController!.shouldAutorotate
        }
    }
    // 返回最上层的子Controller的supportedInterfaceOrientations
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return self.topViewController!.supportedInterfaceOrientations
        }
    }
    // 返回最上层的子Controller的preferredInterfaceOrientationForPresentation
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        get {
            return self.topViewController!.preferredInterfaceOrientationForPresentation
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return topViewController!.preferredStatusBarStyle
        }
    }
}

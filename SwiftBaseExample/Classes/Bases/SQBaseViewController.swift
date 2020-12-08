//
//  SQBaseViewController.swift
//  SwiftBaseExample
//
//  Created by administrator on 2019/5/26.
//  Copyright © 2019 administrator. All rights reserved.
//

import Foundation
import UIKit


class SQBaseViewController: UIViewController {
    
    var leftItem : UIBarButtonItem?
    var rightItem: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        setNavigatoinBar()
        
    }
    
    func setNavigatoinBar() {
        if let count = navigationController?.viewControllers.count,count > 1 {
            let backBtn = UIBarButtonItem.init()
            backBtn.title = NSLocalizedString("返回", comment: "")
            navigationItem.backBarButtonItem = backBtn
        }
    }
    
    func leftAction() {
        if let count = navigationController?.viewControllers.count,count > 1 {
            navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let count = navigationController?.viewControllers.count,count == 1  {
            tabBarController?.tabBar.isHidden = false
        }else{
            tabBarController?.tabBar.isHidden = true
        }
        navigationController?.navigationBar.shadowImage = UIImage.init()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //隐藏弹出框
        navigationController?.navigationBar.shadowImage = nil
    }
    
    override var shouldAutorotate: Bool{
        get {
            return false
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        get {
            return .portrait
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
}

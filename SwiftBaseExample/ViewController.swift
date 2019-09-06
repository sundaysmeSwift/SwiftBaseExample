//
//  ViewController.swift
//  SwiftBaseExample
//
//  Created by administrator on 2019/5/26.
//  Copyright © 2019 administrator. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let nibName = "\(self)".split{$0 == "."}.map(String.init).last!
//        let nibName = "\(self)"
//        let vc = UIViewController()
        print(nibName)
        
//        let ab = self.getStringPrice(price: 12)
    }


    
    
}


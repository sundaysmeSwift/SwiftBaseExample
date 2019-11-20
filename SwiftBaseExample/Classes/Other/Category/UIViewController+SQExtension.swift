//
//  UIViewController+SQExtension.swift
//  SwiftBaseExample
//
//  Created by 张少晴 on 2019/9/6.
//  Copyright © 2019 administrator. All rights reserved.
//

import UIKit

extension UIViewController {
    
    
    //MARK:- loadfromnib
    class func loadFromNibNamed(nibNamed: String, bundle : Bundle? = nil) -> UIViewController? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIViewController
    }
}

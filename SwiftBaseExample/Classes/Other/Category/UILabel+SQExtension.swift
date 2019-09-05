//
//  UILabelSQExtension.swift
//  SwiftExample
//
//  Created by 曹亮亮 on 2019/9/5.
//  Copyright © 2019 曹亮亮. All rights reserved.
//

import UIKit

extension UILabel {
    class func label(frame:CGRect,title:NSString,textColor:UIColor,font:Float,textAlignment:NSTextAlignment,numberOfline:NSInteger) -> UILabel {
        let lable = UILabel.init()
        if !frame.isEmpty {
            lable.frame = frame;
        }
        if !title.isEqual(to: "") {
            lable.text = title as String
        }
        lable.font = UIFont.systemFont(ofSize: CGFloat(font))
        lable.textColor = textColor
        lable.textAlignment = textAlignment
        lable.numberOfLines = numberOfline
        
        return lable
    }
    
}

//
//  UIViewSQExtension.swift
//  SwiftExample
//
//  Created by 曹亮亮 on 2019/9/5.
//  Copyright © 2019 曹亮亮. All rights reserved.
//

import UIKit


extension UIView {
    func setShadow(shadowColor: CGColor, shadowOpacity: Float, shadowOffset: CGSize, shadowRadius: CGFloat) {
        self.layer.shadowColor = shadowColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
    }
    // MARK: - UI-Get
    func top()-> CGFloat {
        return self.frame.minY
    }
    func bottom()-> CGFloat {
        return self.frame.maxY
    }
    func right()-> CGFloat {
        return self.frame.maxX
    }
    func left()-> CGFloat {
        return self.frame.minX
    }
    
    // MARK: - UI-Set
    func setX(x: CGFloat) {
        self.frame = CGRect(x: x, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.height)
    }
    func setY(y: CGFloat) {
        self.frame = CGRect(x: self.frame.origin.x, y: y, width: self.frame.size.width, height: self.frame.height)
    }
    func setWidth(width: CGFloat) {
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: width, height: self.frame.height)
    }
    func setHeight(height: CGFloat) {
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: height)
    }
}

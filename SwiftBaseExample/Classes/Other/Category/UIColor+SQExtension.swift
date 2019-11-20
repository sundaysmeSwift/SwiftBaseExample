//
//  UIColorSQExtension.swift
//  SwiftExample
//
//  Created by 张少晴 on 2019/9/5.
//  Copyright © 2019 张少晴. All rights reserved.
//

import UIKit


extension UIColor {
    
    //MARK
    class func colorWithHexString(hex:String)-> UIColor {
        
        func hex2dec(num:String) -> Float {
            let str = num.uppercased()
            var sum:Float = 0
            for i in str.utf8 {
                sum = sum * 16 + Float(i) - 48 // 0-9 从48开始
                if i >= 65 {                 // A-Z 从65开始，但有初始值10，所以应该是减去55
                    sum -= 7
                }
            }
            return sum
        }
        
        var hexString = hex
        
        if (hexString.hasPrefix("#")) {
            hexString = (hexString as NSString).substring(from: 1)
        }
        
        let index = hexString.index(hexString.startIndex, offsetBy: 2)
        let index2 = hexString.index(hexString.startIndex, offsetBy: 4)
        let range = index ..< index2
        
        let s1:String = String(hexString[..<index])
        let s2:String = String(hexString[range])
        let s3 = String(hexString[index2...])
        
        return UIColor(red:CGFloat(hex2dec(num: s1))/255.0, green:CGFloat(hex2dec(num: s2)) / 255.0, blue:CGFloat(hex2dec(num: s3)) / 255.0, alpha:1)
    }
    
    
    // 便利初始化方法
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    /// 背景灰色 f8f9f7
    class func globalBackgroundColor() -> UIColor {
        return UIColor(r: 248, g: 249, b: 247)
    }
    
    /// 背景蓝色 4CADFD
    class func globalBlueColor() -> UIColor {
        return UIColor(r: 76, g: 173, b: 253)
    }
    
    /// RGBA的颜色设置 D23F42
    func rgb(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
        return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }
    
    /// 红色 D23F42 ，F55A5D （245, 90, 93）
    class func globalRedColor() -> UIColor {
        return UIColor(r: 210, g: 63, b: 66)
    }
    
    /// 随机颜色
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
    
    public convenience init(hex: String) {
        
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        var hex:   String = hex
        
        if hex.hasPrefix("#") {
            let index = hex.index(hex.startIndex, offsetBy: 1)
            hex = String(hex[index...])
        }
        
        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        if scanner.scanHexInt64(&hexValue) {
            switch (hex.count) {
            case 3:
                red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                blue  = CGFloat(hexValue & 0x00F)              / 15.0
            case 4:
                red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                alpha = CGFloat(hexValue & 0x000F)             / 15.0
            case 6:
                red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
            case 8:
                red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
            default:
                print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
            }
        } else {
            print("Scan hex error")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
   
}

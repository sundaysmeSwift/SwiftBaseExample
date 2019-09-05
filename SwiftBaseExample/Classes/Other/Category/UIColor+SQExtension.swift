//
//  UIColorSQExtension.swift
//  SwiftExample
//
//  Created by 曹亮亮 on 2019/9/5.
//  Copyright © 2019 曹亮亮. All rights reserved.
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
    
    
   
}

//
//  String+SQExtension.swift
//  SwiftBaseExample
//
//  Created by 曹亮亮 on 2019/9/6.
//  Copyright © 2019 administrator. All rights reserved.
//

import UIKit


extension String {
    
    subscript (range: Range<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: range.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: range.upperBound)
            return String(self[startIndex..<endIndex])
        }
        
        set {
            let startIndex = self.index(self.startIndex, offsetBy: range.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: range.upperBound)
            let strRange = startIndex..<endIndex
            self.replaceSubrange(strRange, with: newValue)
        }
    }
    
    
    
    /// 计算文本的高度
    func getTextHeight(width: CGFloat) -> CGFloat {
        let size = CGSize(width: width, height: CGFloat(MAXFLOAT))
        return (self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [.font: UIFont.systemFont(ofSize: 16)], context: nil).size.height)
    }
    
    
    //range转换为NSRange
    //扩展的是String类，不可改为NSRange或者Range的扩展，因为samePosition，utf16是String里的
    
    func nsRange(from range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: utf16)
        let to = range.upperBound.samePosition(in: utf16)
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from!),
                       length: utf16.distance(from: from!, to: to!))
    }
    
    //NSRange转化为range
    //扩展的是String类，不可改为NSRange或者Range的扩展，因为utf16是String里的
    
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }
    
    func formatPrice(price:String)->String{
        if price.contains(":") {
            return price
        }
        var hander:NSDecimalNumberHandler?
        let priceF:CGFloat = CGFloat((price as NSString).floatValue)
        if priceF >= 1000 {
            hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 3, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        }else if priceF >= 100 && priceF < 1000 {
            hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 4, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        }else if priceF >= 10 && priceF < 100 {
            hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 5, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        }else{
            hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 6, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        }
        
        let decimalprice = NSDecimalNumber.init(string: price)
        let decimalprice1 = NSDecimalNumber.init(string: "0")
        let r3 = decimalprice.adding(decimalprice1, withBehavior: hander)
        if r3.stringValue == "NaN" {
            return price
        }
        return r3.stringValue
    }
    
    
    func formatPriceF(priceF: CGFloat)->String{
        
        var hander:NSDecimalNumberHandler?
        
        if priceF >= 1000 {
            hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 3, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        }else if priceF >= 100 && priceF < 1000 {
            hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 4, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        }else if priceF >= 10 && priceF < 100 {
            hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 5, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        }else{
            hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 6, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        }
        
        let price:String = priceF.description
        
        let decimalprice = NSDecimalNumber.init(string: price)
        let decimalprice1 = NSDecimalNumber.init(string: "0")
        let r3 = decimalprice.adding(decimalprice1, withBehavior: hander)
        if r3.stringValue == "NaN" {
            return price
        }
        return r3.stringValue
    }
}

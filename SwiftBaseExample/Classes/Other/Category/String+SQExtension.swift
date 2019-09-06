//
//  String+SQExtension.swift
//  SwiftBaseExample
//
//  Created by 曹亮亮 on 2019/9/6.
//  Copyright © 2019 administrator. All rights reserved.
//

import UIKit


extension String {
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

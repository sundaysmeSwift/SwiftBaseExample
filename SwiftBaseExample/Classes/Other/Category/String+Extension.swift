//
//  String+Extension.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/6/16.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit
import CommonCrypto

extension String {
    //MARK:- price
    static func getStringPrice(price:String,priceF:Float)->String{
        var hander:NSDecimalNumberHandler?
        if priceF >= 10000000{
            hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 0, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        }else if priceF >= 1000000 && priceF < 10000000{
            hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 1, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        }else if priceF >= 100000 && priceF < 1000000{
            hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        }else if priceF >= 10000 && priceF < 100000 {
            hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 3, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        }else if priceF >= 1000 && priceF < 10000 {
            hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 4, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        }else if priceF >= 100 && priceF < 1000 {
            hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 5, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        }else if priceF >= 10 && priceF < 100 {
            hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 6, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        }else{
            hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 7, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        }
        
        let decimalprice = NSDecimalNumber.init(string: price)
        let decimalprice1 = NSDecimalNumber.init(string: "0")
        let r3 = decimalprice.adding(decimalprice1, withBehavior: hander)
        return r3.stringValue
    }
    
    
    
    func timeStampToString()->String {
        
        let string = NSString(string: self)
        
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy-MM-dd HH:mm:ss"
        
        let date = NSDate(timeIntervalSince1970: timeSta/1000)
        
        return dfmatter.string(from: date as Date)
    }
    
    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        free(result)
        return String(format: hash as String)
    }
    
    func cancleScientific()-> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        let number = formatter.number(from: self)
        if let n = number {
            //let lengthOfDecimal = self.split(separator: ".")[1].count
            if self.contains("E") || self.contains("e") || self.count > 15 {
                return String(format:"%.8f", n.doubleValue)
            }else {
                if number!.doubleValue <= Double(0.0) {
                    return "0"
                }
                return self
            }
        }else{
            return "0"
        }
    }
    
    //获取小数点位数
    func countOfPresicion()-> Int {
        let array = self.split(separator: ".")
        if array.count == 2 {
            let presicion = array[1]
            return presicion.count
        }
        return 0
    }
    
    func splitToIntArray(seperator: Character)-> [Int] {
        return self.split(separator: seperator).map({ (str) -> Int in
            return Int(str) ?? -1
        })
    }
    
    func getCoinAndQutoeCoinFromSymbol()->(String, String) {
        let coinPairArray = self.split(separator: "_")
        let coinName = String(coinPairArray[0])
        let coinQuote = String(coinPairArray[1])
        return (coinName, coinQuote)
    }
    
    func toLotteryNumberString()-> String {
        if let number = Int(self) {
            if number < 10 {
                return "0" + self
            }else {
                return self
            }
        }else {
            return "-1"
        }
    }
    //    func stringValue()-> String {
    //        if self == nil {
    //            return ""
    //        }else {
    //            return self
    //        }
    //    }
    
}







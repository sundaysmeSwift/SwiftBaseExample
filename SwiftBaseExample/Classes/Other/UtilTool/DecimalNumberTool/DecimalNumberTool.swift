//
//  DecimalNumberTool.swift
//  SwiftBaseExample
//
//  Created by 曹亮亮 on 2019/9/6.
//  Copyright © 2019 administrator. All rights reserved.
//

import UIKit


func floatWithdecimalNumber(num:Double) -> Float {
    return decimalNumber(num: num).floatValue
}
    
func doubleWithdecimalNumber(num:Double) -> Double {
    return decimalNumber(num: num).doubleValue
}
        
func stringWithDecimalNumber(num:Double) -> String {
    return decimalNumber(num: num).stringValue
}
            
func stringWithDecimalString(string:String) -> String{

    return decimalString(string: string).stringValue
}
    
func decimalNumber(num:Double) -> NSDecimalNumber {
    let numString: String = String.init(format: "%lf", num)
    return decimalString(string: numString)
}
    
func decimalString(string:String) -> NSDecimalNumber {

    return NSDecimalNumber.init(string: string)
}


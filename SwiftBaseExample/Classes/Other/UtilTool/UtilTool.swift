//
//  UtilTool.swift
//  SwiftBaseExample
//
//  Created by 曹亮亮 on 2019/9/6.
//  Copyright © 2019 administrator. All rights reserved.
//

import UIKit


func isBlankString(value: AnyObject?)->Bool{
    //首先判断是否为nil
    if (nil == value) {
        //对象是nil，直接认为是空串
        return true
    }else{
        //然后是否可以转化为String
        if let myValue  = value as? String{
            //然后对String做判断
            return myValue == "" || myValue == "(null)" || 0 == myValue.count
        }else{
            //字符串都不是，直接认为是空串
            return true
        }
    }
}

 func trimNumStrWithText(text:String) -> String{
    if !text.contains(".") {
        return text;
    }
    let range = text.range(of: ".");
    let nsrange = text.nsRange(from: range!)
    let dotIndex = nsrange.location
    
    if ((text as NSString).length - dotIndex < 3) {
        return  text;
    }
    let indexStart = text.index(text.startIndex, offsetBy: dotIndex)
    let indexEnd = text.index(text.startIndex, offsetBy: dotIndex + 3) //swift 2.0+

    let rangea = text.range(from: NSRange(location: 0, length: dotIndex + 3))

    
    let numStr = text[rangea!]
    let lastStr = numStr.split(separator: ".").last
    if lastStr == "00" {
        return String(text[..<indexStart])
    }
    return String(text[..<indexEnd])
}

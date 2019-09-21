//
//  InterUtil.swift
//  SwiftBaseExample
//
//  Created by 曹亮亮 on 2019/9/21.
//  Copyright © 2019 administrator. All rights reserved.
//

import UIKit


//MARK:- 超链接
func getAttributeWith(sender: AnyObject, inText text: String, originFontsize:CGFloat,originColor:UIColor, attriubteFont:CGFloat, attributeColor:UIColor) -> NSAttributedString {
    let totalStr = NSMutableAttributedString.init(string: text)
    totalStr.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: originFontsize),NSAttributedString.Key.foregroundColor: originColor], range: NSRange.init(location: 0, length: text.count))
    
    let paragraphStyle = NSMutableParagraphStyle.init()
    paragraphStyle.lineSpacing = 5.0
    paragraphStyle.lineBreakMode = NSLineBreakMode.byTruncatingTail
    paragraphStyle.alignment = .left
    totalStr.addAttributes([NSAttributedString.Key.paragraphStyle : paragraphStyle], range: NSRange.init(location: 0, length: text.count))
    
    if sender.isKind(of: NSArray.self) {
        let originStr = text
        //        weak var weakSelf = self
        sender.enumerateObjects { (str, idx, stop) in
            let range = originStr.range(of: str as! String)
            let nsRange = NSRange.init(range!, in: originStr)
            totalStr.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: attriubteFont), NSAttributedString.Key.foregroundColor:attributeColor], range: nsRange)
            //            originStr.replacingCharacters(in: range!, with: getStringWithRange(nsRange: nsRange))
            //weakSelf?.
        }
    }else if(sender.isKind(of: NSString.self)){
        let range = text.range(of: sender as! String)
        let nsRange = NSRange.init(range!, in: text)
        totalStr.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: attriubteFont), NSAttributedString.Key.foregroundColor:attributeColor], range: nsRange)
    }
    return totalStr
}


func getStringWithRange(nsRange:NSRange) -> String {
    let str = String.init(repeating: " ", count: nsRange.length)
    return str
}

//MARK:- url
//
////判断网络是否可用
//func urlIsAvailable(urlStr: String) {
//    guard let requestURL = URL.init(string: urlStr) else {
//        return
//    }
//    var request = URLRequest.init(url: requestURL)
//    request.httpMethod = "HEAD"
//    let session: URLSession = URLSession.init(configuration: URLSessionConfiguration.default)
//    let task = session.dataTask(with: request) { (data, response, error) in
//        if (error == nil) {
//
//        }else{
//            //不可用
//        }
//    }
//    task.resume()
//}
//拼接http://或者https://
func getURlWithWebsite(urlStr:String,htp:String = "https://") -> String {
    var rstr = ""
    let urlTStr = urlStr.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) //whitespaceCharacterSet
    
    if !isBlankString(value: urlTStr as AnyObject){
        guard let urlRange = urlStr.range(of: "://") else {
            
            return htp + urlStr
            
        }
//        let startIndex = urlStr.index(urlStr.startIndex, offsetBy: 0)
        //        let endIndex = urlStr.index(urlStr.startIndex, offsetBy: 7)
        let scheme = urlStr[0..<urlRange.lowerBound]
        
        if ((scheme.caseInsensitiveCompare("http") == .orderedSame) || (scheme.caseInsensitiveCompare("https") == .orderedSame)){
            rstr = urlStr
            
        }else{
            //不支持的URL方案
            rstr = urlStr
        }
    }
    return rstr;
}

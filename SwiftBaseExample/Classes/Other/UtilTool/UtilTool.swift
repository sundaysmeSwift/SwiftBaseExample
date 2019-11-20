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


//获取启动图
func getLaunchImage()-> UIImage? {
    let viewSize = UIScreen.main.bounds.size
    let viewOr = "Portrait"
    var launchImage = ""
    if let launchImages = Bundle.main.infoDictionary?["UILaunchImages"] as? [[String: String]] {
        for dict in launchImages {
            let imageSize = NSCoder.cgSize(for: dict["UILaunchImageSize"] ?? "")
            if __CGSizeEqualToSize(viewSize, imageSize) && viewOr == dict["UILaunchImageOrientation"] {
                launchImage = dict["UILaunchImageName"] ?? ""
            }
        }
    }
    return UIImage(named: launchImage)
}


func timeAndString(time:String)->String{
    
    var time1 = Double(time)
    if time.count>13 {
        time1 = time1!/1000
    }else if time.count == 10{
        time1 = time1!*1000
    }
    let data = NSDate.init(timeIntervalSince1970: time1!/1000.0)
    let dataFormat = DateFormatter.init()
    dataFormat.dateFormat = "yyy-MM-dd HH:mm:ss"
    let string = dataFormat.string(from: data as Date)
    return string
}

func timeYearAndString(time:String)->String{
    if time == ""{
        return ""
    }
    var time1 = Double(time)
    if time.count>13 {
        time1 = time1!/1000
    }
    let data = NSDate.init(timeIntervalSince1970: time1!/1000.0)
    let dataFormat = DateFormatter.init()
    dataFormat.dateFormat = "yyy-MM-dd"
    let string = dataFormat.string(from: data as Date)
    return string
}

// MARK: - 查找顶层控制器、
// 获取顶层控制器 根据window
func getTopVC() -> (UIViewController?) {
    var window = UIApplication.shared.keyWindow
    //是否为当前显示的window
    if window?.windowLevel != UIWindow.Level.normal{
        let windows = UIApplication.shared.windows
        for  windowTemp in windows{
            if windowTemp.windowLevel == UIWindow.Level.normal{
                window = windowTemp
                break
            }
        }
    }
    let vc = window?.rootViewController
    return getTopVC(withCurrentVC: vc)
}
///根据控制器获取 顶层控制器
func getTopVC(withCurrentVC VC :UIViewController?) -> UIViewController? {
    if VC == nil {
        print(NSLocalizedString("🌶： 找不到顶层控制器",  comment: ""))
        return nil
    }
    if let presentVC = VC?.presentedViewController {
        //modal出来的 控制器
        return getTopVC(withCurrentVC: presentVC)
    }else if let tabVC = VC as? UITabBarController {
        // tabBar 的跟控制器
        if let selectVC = tabVC.selectedViewController {
            return getTopVC(withCurrentVC: selectVC)
        }
        return nil
    } else if let naiVC = VC as? UINavigationController {
        // 控制器是 nav
        return getTopVC(withCurrentVC:naiVC.visibleViewController)
    } else {
        // 返回顶控制器
        return VC
    }
}

//func getStringPrice(price:String,priceF:Float)->String{
//    var hander:NSDecimalNumberHandler?
//    if priceF >= 10000000{
//        hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 0, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
//    }else if priceF >= 1000000 && priceF < 10000000{
//        hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 1, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
//    }else if priceF >= 100000 && priceF < 1000000{
//        hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
//    }else if priceF >= 10000 && priceF < 100000 {
//        hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 3, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
//    }else if priceF >= 1000 && priceF < 10000 {
//        hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 4, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
//    }else if priceF >= 100 && priceF < 1000 {
//        hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 5, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
//    }else if priceF >= 10 && priceF < 100 {
//        hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 6, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
//    }else{
//        hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 7, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
//    }
//    
//    let decimalprice = NSDecimalNumber.init(string: price)
//    let decimalprice1 = NSDecimalNumber.init(string: "0")
//    let r3 = decimalprice.adding(decimalprice1, withBehavior: hander)
//    return r3.stringValue
//}


//MARK:- 返回固定小数点位数的小数
func sformatPriceF(priceF: CGFloat, scale:Int = 2)->String{
   
   var hander:NSDecimalNumberHandler?
   
   hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: Int16(scale), raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
   let price:String = priceF.description
   
   let decimalprice = NSDecimalNumber.init(string: price)
   let decimalprice1 = NSDecimalNumber.init(string: "0")
   let r3 = decimalprice.adding(decimalprice1, withBehavior: hander)
   if r3.stringValue == "NaN" {
       return price
   }
    return r3.stringValue
}


func sformatPriceStr(price:String, scale:Int = 2)->String{
    if price.contains(":") {
        return price
    }
    var hander:NSDecimalNumberHandler?
    hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: Int16(scale), raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
    let decimalprice = NSDecimalNumber.init(string: price)
    let decimalprice1 = NSDecimalNumber.init(string: "0")
    let r3 = decimalprice.adding(decimalprice1, withBehavior: hander)
    if r3.stringValue == "NaN" {
        return price
    }
    return r3.stringValue
}


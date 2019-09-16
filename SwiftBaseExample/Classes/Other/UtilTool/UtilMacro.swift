//
//  Util.swift
//  SwiftBaseExample
//
//  Created by 曹亮亮 on 2019/9/11.
//  Copyright © 2019 administrator. All rights reserved.
//

import UIKit

let kStatusBarHeight = UIApplication.shared.statusBarFrame.size.height
let kNavHeight = CGFloat(44)
let kNavAndStatusBarHeight = UIApplication.shared.statusBarFrame.size.height + 44
let kTabBarHeight: CGFloat = (UIApplication.shared.statusBarFrame.size.height > 20.0 ? 83.0:49.0)
let kTabBarBottom: CGFloat = (UIApplication.shared.statusBarFrame.size.height > 20.0 ? 34.0:0.0)

let kSafeBottomHeight: CGFloat = {
    if #available(iOS 11.0, *) {
        return (UIApplication.shared.delegate as! AppDelegate).window!.safeAreaInsets.bottom
    }
    return CGFloat(0)
}()

let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height
let kScreenSize = UIScreen.main.bounds

let kApplication = UIApplication.shared
let kAppDelegate = UIApplication.shared.delegate
let kUserDefaults = UserDefaults.standard
let kNotificationCenter = NotificationCenter.default
let kAppName = (Bundle.main.infoDictionary!["CFBundleDisplayName"] as? String) ?? ""


func ZefLocalize(_ str: String)-> String {
    return NSLocalizedString(str, comment: "")
}
func ZefLocalizeStr(_ str: String)-> String {
    return NSLocalizedString(str, comment: str)
}

func UIColorRGB(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0)-> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
}

typealias funcBlock = (_ any : AnyObject) -> (Void)



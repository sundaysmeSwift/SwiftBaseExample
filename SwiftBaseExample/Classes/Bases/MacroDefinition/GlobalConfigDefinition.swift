//
//  GlobalConfigDefinition.swift
//  SwiftBaseExample
//
//  Created by administrator on 2019/5/26.
//  Copyright © 2019 administrator. All rights reserved.
//

import Foundation
import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
//状态栏高度
let STATUSBAR_HEIGHT = UIApplication.shared.statusBarFrame.size.height

let IS_IPHONE_X = STATUSBAR_HEIGHT > 20 ? true : false
let NAVBAR_HEIGHT:CGFloat = 44
let STATUS_AND_NAV_BAR_HEIGHT:CGFloat = IS_IPHONE_X == true ? 88.0 : 64.0
let KSTATUS_AND_NAV_BAR_HEIGHT:CGFloat = STATUSBAR_HEIGHT + NAVBAR_HEIGHT

let TABBAR_HEIGHT:CGFloat = IS_IPHONE_X == true ? 83.0 : 49.0
let BOTTOM_SAFE_HEIGHT:CGFloat = IS_IPHONE_X == true ? 34 : 0

//MARK - TabBar
let TABBAR_FONT:CGFloat = 12
let TABBAR_COLOR_NOR : UIColor = UIColor.black
let TABBAR_COLOR_SEL : UIColor = UIColor.gray


//
//  EnumUtils.swift
//  Quantbroker
//
//  Created by 张少晴 on 2019/9/12.
//  Copyright © 2019 huoju. All rights reserved.
//

import UIKit

//MARK:- 我的钱包--币币h
enum eExampleName:String{
    case name1 = "0"          //
    case name2 = "1"
    func description()->String{ //enum转String
        return self.rawValue
    }

}


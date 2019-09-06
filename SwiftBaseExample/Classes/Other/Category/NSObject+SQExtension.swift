//
//  NSObject+SQExtension.swift
//  SwiftBaseExample
//
//  Created by 曹亮亮 on 2019/9/6.
//  Copyright © 2019 administrator. All rights reserved.
//

import UIKit

extension NSObject
{
    // MARK:返回className
    var className:String{
        get{
            let name =  type(of: self).description()
            if(name.contains(".")){
                return name.components(separatedBy: ".")[1];
            }else{
                return name;
            }
            
        }
    }

    
}


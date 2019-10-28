//
//  UITextField+SQExtension.swift
//  SwiftBaseExample
//
//  Created by 曹亮亮 on 2019/9/29.
//  Copyright © 2019 administrator. All rights reserved.
//

import UIKit

extension UITextField{

    
    
    
    
    
    //MARK:-设置暂位文字的颜色
    var placeholderColor:UIColor {

        get{
            let color =   self.value(forKeyPath: "_placeholderLabel.textColor")
            if(color == nil){
                return UIColor.white;
            }
            return color as! UIColor;

        }

        set{

          self.setValue(newValue, forKeyPath: "_placeholderLabel.textColor")
        }


    }

//MARK:-设置暂位文字的字体
    var placeholderFont:UIFont{
        get{
            let font =   self.value(forKeyPath: "_placeholderLabel.font")
            if(font == nil){
                return UIFont.systemFont(ofSize: 14);
            }
            return font as! UIFont;
        }


        set{


         self.setValue(newValue, forKeyPath: "_placeholderLabel.font")
        }

    }


}
————————————————
版权声明：本文为CSDN博主「Micah_A」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/lvchenqiang_/article/details/78539953

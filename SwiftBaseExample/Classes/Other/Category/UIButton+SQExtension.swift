//
//  UIButtonSQExtension.swift
//  SwiftExample
//
//  Created by 曹亮亮 on 2019/9/5.
//  Copyright © 2019 曹亮亮. All rights reserved.
//

import UIKit

extension UIButton {
    class func button(frame:CGRect,title:NSString,textColor:UIColor?,bgColor:UIColor?,textFont:Float,target:Any,action:Selector) -> UIButton {
    let button = UIButton.init(type: UIButton.ButtonType.custom)
    if !frame.isEmpty {
    button.frame = frame;
    }
    if !title.isEqual(to: "") {
    button.setTitle(title as String, for: UIControl.State.normal)
    }
    button.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(textFont))
    if bgColor != nil {
    button.backgroundColor = bgColor
    }
    if textColor != nil {
    button.setTitleColor(textColor, for: UIControl.State.normal)
    }
    button.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
    return button
    }
    
    class func button(frame:CGRect,title:NSString,ntextColor:UIColor?,stextColor:UIColor?,bgColor:UIColor?,textFont:Float,target:Any,action:Selector) -> UIButton {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        if !frame.isEmpty {
            button.frame = frame;
        }
        if !title.isEqual(to: "") {
            button.setTitle(title as String, for: UIControl.State.normal)
        }
        button.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(textFont))
        if bgColor != nil {
            button.backgroundColor = bgColor
        }
        if ntextColor != nil {
            button.setTitleColor(ntextColor, for: UIControl.State.normal)
        }
        if stextColor != nil {
            button.setTitleColor(stextColor, for: UIControl.State.selected)
        }
        button.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
        return button
    }
    
    class func button(frame:CGRect,title:NSString,ntextColor:UIColor?,nbgColor:UIColor?,sbgColor:UIColor?,textFont:Float,target:Any,action:Selector) -> UIButton {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        if !frame.isEmpty {
            button.frame = frame;
        }
        if !title.isEqual(to: "") {
            button.setTitle(title as String, for: UIControl.State.normal)
        }
        button.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(textFont))
        if nbgColor != nil {
            button.setBackgroundImage(UIImage.image(color: nbgColor!), for: UIControl.State.normal)
        }
        if sbgColor != nil {
            button.setBackgroundImage(UIImage.image(color: sbgColor!), for: UIControl.State.selected)
        }
        if ntextColor != nil {
            button.setTitleColor(ntextColor, for: UIControl.State.normal)
        }

        button.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
        return button
    }
    
    class func button(frame:CGRect,title:NSString,ntextColor:UIColor?,stextColor:UIColor?,nbgColor:UIColor?,sbgColor:UIColor?,textFont:Float,target:Any,action:Selector) -> UIButton {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        if !frame.isEmpty {
            button.frame = frame;
        }
        if !title.isEqual(to: "") {
            button.setTitle(title as String, for: UIControl.State.normal)
        }
        button.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(textFont))
        if nbgColor != nil {
            button.setBackgroundImage(UIImage.image(color: nbgColor!), for: UIControl.State.normal)
        }
        if sbgColor != nil {
            button.setBackgroundImage(UIImage.image(color: sbgColor!), for: UIControl.State.selected)
        }
        if ntextColor != nil {
            button.setTitleColor(ntextColor, for: UIControl.State.normal)
        }
        if stextColor != nil {
            button.setTitleColor(stextColor, for: UIControl.State.selected)
        }
        button.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
        return button
    }
}

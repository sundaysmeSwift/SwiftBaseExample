//
//  UIButtonSQExtension.swift
//  SwiftExample
//
//  Created by 张少晴 on 2019/9/5.
//  Copyright © 2019 张少晴. All rights reserved.
//

import UIKit

extension UIButton {
    //MARK:- helper
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
    
    
    //MARK:- 图片标题对调
    @objc func set(image anImage: UIImage?, title: String,
                   titlePosition: UIView.ContentMode, additionalSpacing: CGFloat, state: UIControl.State){
        self.imageView?.contentMode = .center
        self.setImage(anImage, for: state)
        
        positionLabelRespectToImage(title: title, position: titlePosition, spacing: additionalSpacing)
        
        self.titleLabel?.contentMode = .center
        self.setTitle(title, for: state)
    }
    
    private func positionLabelRespectToImage(title: String, position: UIView.ContentMode,
                                             spacing: CGFloat) {
        let imageSize = self.imageRect(forContentRect: self.frame)
        let titleFont = self.titleLabel?.font!
        let titleSize = title.size(withAttributes: [NSAttributedString.Key.font: titleFont!])
        
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets
        
        switch (position){
        case .top:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .bottom:
            titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .left:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0,
                                       right: -(titleSize.width * 2 + spacing))
        case .right:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
    
    
    
    /////
    
    /// 快速调整图片与文字位置
    ///
    /// - Parameters:
    ///   - buttonMode: 图片所在位置
    ///   - spacing: 文字和图片之间的间距
    func hw_locationAdjust(buttonMode: UIView.ContentMode,
                           spacing: CGFloat) {
        let imageSize = self.imageRect(forContentRect: self.frame)
        let titleFont = self.titleLabel?.font!
        let titleSize = titleLabel?.text?.size(withAttributes: [kCTFontAttributeName as NSAttributedString.Key: titleFont!]) ?? CGSize.zero
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets
        switch (buttonMode){
        case UIView.ContentMode.top:
            titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing)/2,
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing)/2, left: 0, bottom: 0, right: -titleSize.width)
        case UIView.ContentMode.bottom:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing)/2,
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing)/2, left: 0, bottom: 0, right: -titleSize.width)
        case UIView.ContentMode.left:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case UIView.ContentMode.right:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0,
                                       right: -(titleSize.width * 2 + spacing))
        default:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing)/2,
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing)/2, left: 0, bottom: 0, right: -titleSize.width)
            
        }
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
    
}

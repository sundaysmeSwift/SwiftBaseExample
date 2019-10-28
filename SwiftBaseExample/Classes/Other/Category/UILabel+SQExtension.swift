//
//  UILabelSQExtension.swift
//  SwiftExample
//
//  Created by 曹亮亮 on 2019/9/5.
//  Copyright © 2019 曹亮亮. All rights reserved.
//

import UIKit

extension UILabel {
    class func label(frame:CGRect,title:NSString,textColor:UIColor,font:Float,textAlignment:NSTextAlignment,numberOfline:NSInteger) -> UILabel {
        let lable = UILabel.init()
        if !frame.isEmpty {
            lable.frame = frame;
        }
        if !title.isEqual(to: "") {
            lable.text = title as String
        }
        lable.font = UIFont.systemFont(ofSize: CGFloat(font))
        lable.textColor = textColor
        lable.textAlignment = textAlignment
        lable.numberOfLines = numberOfline
        
        return lable
    }
    
    
    // 设置`numberOfLines = 0`的原因：
    // 配合方法`func boundingRect(with constrainedSize: CGSize, font: UIFont, lineSpacing: CGFloat? = nil, lines: Int) -> CGSize`使用，可以很好的解决不能正常显示限制行数的问题；
    // 如果为label设置了限制行数（大于0的前提），使用上面的计算方法（带行间距），同时字符串的实际行数大于限制行数，这时候的高度会使label不能正常显示。
    func setText(with normalString: String, lineSpacing: CGFloat?, frame: CGRect) {
        self.frame = frame
        self.numberOfLines = 0
                
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        if lineSpacing != nil {
            if (frame.height - font.lineHeight) <= lineSpacing! {
                paragraphStyle.lineSpacing = 0
            } else {
                paragraphStyle.lineSpacing = lineSpacing!
            }
        }
        let attributedString = NSMutableAttributedString(string: normalString)
        let range = NSRange(location: 0, length: attributedString.length)
        attributedString.addAttributes([NSAttributedStringKey.font: font], range: range)
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: range)

        self.attributedText = attributedString
    }
}

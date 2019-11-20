//
//  NSMutableAttributedString+SQ.swift
//  SwiftBaseExample
//
//  Created by 张少晴 on 2019/9/6.
//  Copyright © 2019 administrator. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
    
    
    func getAttributeText(text:String,changeText:String,color:UIColor,font:NSInteger)->NSMutableAttributedString{
        if isBlankString(value: text as AnyObject)==true {
            return NSMutableAttributedString();
        }
        
        if NSString.init(string: text).range(of: changeText).location != NSNotFound {
            let noteStr = NSMutableAttributedString.init(string: text)
            let range = NSString.init(string: text).range(of: changeText)
            let attrs:Dictionary<NSAttributedString.Key , Any> = [NSAttributedString.Key.foregroundColor:color,NSAttributedString.Key.font:UIFont.systemFont(ofSize: CGFloat(font))]
            
            noteStr.addAttributes(attrs, range: range)
            return noteStr;
        }
        return NSMutableAttributedString.init(string: text)
        
    }
    
    
    
//    func getPriceAttributeWithPriceNumber(priceNumber: NSNumber) -> NSMutableAttributedString{
//    return [self getPriceAttributeWithPriceNumber:priceNumber font:PingFangSCMedium10];
//    }
//    
//    func (NSMutableAttributedString *)getPriceAttributeWithPriceNumber:(NSNumber *)priceNumber font:(UIFont *)font -> NSMutableAttributedString{
//    return [self getPriceAttributeWithPriceNumber:priceNumber font:font color:ColorHexFC3D42];
//    }
//    
//    func (NSMutableAttributedString *)getPriceAttributeWithPriceNumber:(NSNumber *)priceNumber font:(UIFont *)font color:(UIColor *)color -> NSMutableAttributedString{
//    NSString *priceStr = [ZWDecimalNumberTool stringWithDecimalNumber:[priceNumber doubleValue]];
//    return [self getPriceAttributeWithPriceText:priceStr font:font color:color];
//    }
//    
//    func (NSMutableAttributedString *)getPriceAttributeWithPriceText:(NSString *)priceText font:(UIFont *)font color:(UIColor *)color -> NSMutableAttributedString{
//    NSString *priceUnit = @"￥";
//    NSString *price = [NSString stringWithFormat:@"%@%@",priceUnit,priceText];
//    
//    NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc] initWithString:[self trimNumStrWithText:price]];
//    NSRange range = [price rangeOfString:priceUnit];
//    NSRange pointRange = NSMakeRange(0, range.length);
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    dic[NSFontAttributeName] = font;
//    dic[NSForegroundColorAttributeName] = color;
//    
//    [attribut addAttributes:dic range:pointRange];
//    
//    
//    return attribut;
//    }
//    
    class func getPriceAttributePriceText(priceText: String ,font:UIFont ,color:UIColor) -> NSMutableAttributedString{
    let priceUnit = "￥"
    var attribut = NSMutableAttributedString.init(string: trimNumStrWithText(text: priceText))
    attribut.append(NSAttributedString.init(string: priceUnit))
    let range = priceText.range(of: priceText);
    let pointRange = NSRange(range!, in: attribut.string)
    
    var dic = Dictionary<NSAttributedString.Key, Any>()
    dic[NSAttributedString.Key.font] = font;
    dic[NSAttributedString.Key.foregroundColor] = color;
    
    attribut.addAttributes(dic, range: pointRange)
    
    
    return attribut;
    }
    
    
    class func getPriceAttributePriceTextWithMoneyFont(priceText: String ,textFont:UIFont , moneyFont : UIFont,color:UIColor) -> NSMutableAttributedString{
        let priceUnit = "￥"
        var attribut = NSMutableAttributedString.init(string: trimNumStrWithText(text: priceText))
        attribut.append(NSAttributedString.init(string: priceUnit, attributes: [NSAttributedString.Key.font: moneyFont, NSAttributedString.Key.foregroundColor: color]))
        let range = priceText.range(of: priceText);
        let pointRange = NSRange(range!, in: attribut.string)
        
        var dic = Dictionary<NSAttributedString.Key, Any>()
        dic[NSAttributedString.Key.font] = textFont;
        dic[NSAttributedString.Key.foregroundColor] = color;
        
        attribut.addAttributes(dic, range: pointRange)
        
        
        return attribut;
    }
    
    class func getPriceAttributePriceTextDouble(priceText: String ,textFont:UIFont , moneyFont : UIFont,textColor:UIColor, moneyColor: UIColor) -> NSMutableAttributedString{
        let priceUnit = "￥"
        let attribut = NSMutableAttributedString.init(string: trimNumStrWithText(text: priceText), attributes: [NSAttributedString.Key.font: textFont, NSAttributedString.Key.foregroundColor: textColor])
        attribut.append(NSAttributedString.init(string: priceUnit, attributes: [NSAttributedString.Key.font: moneyFont, NSAttributedString.Key.foregroundColor: moneyColor]))

        return attribut;
    }
}

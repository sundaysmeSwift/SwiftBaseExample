//
//  String+SQExtension.swift
//  SwiftBaseExample
//
//  Created by 曹亮亮 on 2019/9/6.
//  Copyright © 2019 administrator. All rights reserved.
//

import UIKit


extension String {
    
    subscript (range: Range<Int>) -> String {
        get {
            if range.lowerBound < 0 || range.upperBound > self.count {
                return ""
            }
            let startIndex = self.index(self.startIndex, offsetBy: range.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: range.upperBound)
            return String(self[startIndex..<endIndex])
        }
        
        set {
            let startIndex = self.index(self.startIndex, offsetBy: range.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: range.upperBound)
            let strRange = startIndex..<endIndex
            self.replaceSubrange(strRange, with: newValue)
        }
    }
    subscript(r: ClosedRange<Int>) -> String {
        get {
            let start = index(startIndex, offsetBy: r.lowerBound)
            let end = index(startIndex, offsetBy: r.upperBound)
            return self[start...end]
        }
        set {
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            let strRange = startIndex...endIndex
            self.replaceSubrange(strRange, with: newValue)
        }
    }
    
    //MARK:-返回string的长度
    var length:Int{
        get {
            return self.characters.count;
        }
    }
    //MARK:-截取字符串从开始到 index
    func substring(to index: Int) -> String {
        guard let end_Index = validEndIndex(original: index) else {
            return self;
        }
        
        return String(self[startIndex..<end_Index]);
    }
    //MARK:-截取字符串从index到结束
    func substring(from index: Int) -> String {
        guard let start_index = validStartIndex(original: index)  else {
            return self
        }
        return String(self[start_index..<endIndex])
    }
    //MARK:-切割字符串(区间范围 前闭后开)
    func sliceString(_ range:CountableRange<Int>)->String{
        
        guard
            let startIndex = validStartIndex(original: range.lowerBound),
            let endIndex   = validEndIndex(original: range.upperBound),
            startIndex <= endIndex
            else {
                return ""
        }
        
        return String(self[startIndex..<endIndex])
    }
    //MARK:-切割字符串(区间范围 前闭后闭)
    func sliceString(_ range:CountableClosedRange<Int>)->String{
        
        guard
            let start_Index = validStartIndex(original: range.lowerBound),
            let end_Index   = validEndIndex(original: range.upperBound),
            startIndex <= endIndex
            else {
                return ""
        }
        if(endIndex.encodedOffset <= end_Index.encodedOffset){
            return String(self[start_Index..<endIndex])
        }
        return String(self[start_Index...end_Index])
        
    }
    //MARK:-校验字符串位置 是否合理，并返回String.Index
    private func validIndex(original: Int) -> String.Index {
        
        switch original {
        case ...startIndex.encodedOffset : return startIndex
        case endIndex.encodedOffset...   : return endIndex
        default                          : return index(startIndex, offsetBy: original)
        }
    }
    //MARK:-校验是否是合法的起始位置
    private func validStartIndex(original: Int) -> String.Index? {
        guard original <= endIndex.encodedOffset else { return nil }
        return validIndex(original:original)
    }
    //MARK:-校验是否是合法的结束位置
    private func validEndIndex(original: Int) -> String.Index? {
        guard original >= startIndex.encodedOffset else { return nil }
        return validIndex(original:original)
    }

    
    //MARK:- 去除字符串两端的空白字符
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    func subString(to: Int) -> String {
        var to = to
        if to > self.count {
            to = self.count
        }
        return String(self.prefix(to))
    }
    
    func subString(from: Int) -> String {
        if from >= self.count {
            return ""
        }
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.endIndex
        return String(self[startIndex..<endIndex])
    }
    
    func subString(start: Int, end: Int) -> String {
        if start < end {
            let startIndex = self.index(self.startIndex, offsetBy: start)
            let endIndex = self.index(self.startIndex, offsetBy: end)
            
            return String(self[startIndex..<endIndex])
        }
        return ""
    }

    //MARK:- NSRange == Range
    //range转换为NSRange
    //扩展的是String类，不可改为NSRange或者Range的扩展，因为samePosition，utf16是String里的
    
    func nsRange(from range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: utf16)
        let to = range.upperBound.samePosition(in: utf16)
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from!),
                       length: utf16.distance(from: from!, to: to!))
    }
    
    //NSRange转化为range
    //扩展的是String类，不可改为NSRange或者Range的扩展，因为utf16是String里的
    
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }
    //MARK:- PriceFormatter
    
    func getNSNumber(roundingMode:RoundingMode = .down, scale:Int = 2, raiseraiseOnExactness:Bool = false,raiseOnOverflow:Bool = false, raiseOnUnderflow:Bool = false, raiseOnDivideByZero:Bool = true)->String{
        let num = NSDecimalNumber(string: self)
        let num2 = NSDecimalNumber(string: "0")
        let haviors = NSDecimalNumberHandler.init(roundingMode: roundingMode, scale: scale, raiseOnExactness: raiseOnExactness, raiseOnOverflow: raiseOnOverflow, raiseOnUnderflow: raiseOnUnderflow, raiseOnDivideByZero: raiseOnDivideByZero)
        let num3 = num.adding(num2, withBehavior: haviors)
        return num3.stringValue
    }

    class formatPrice(price:String)->String{
        if price.contains(":") {
            return price
        }
        var hander:NSDecimalNumberHandler?
        let priceF:CGFloat = CGFloat((price as NSString).floatValue)
        if priceF >= 1000 {
            hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 3, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        }else if priceF >= 100 && priceF < 1000 {
            hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 4, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        }else if priceF >= 10 && priceF < 100 {
            hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 5, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        }else{
            hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 6, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        }
        
        let decimalprice = NSDecimalNumber.init(string: price)
        let decimalprice1 = NSDecimalNumber.init(string: "0")
        let r3 = decimalprice.adding(decimalprice1, withBehavior: hander)
        if r3.stringValue == "NaN" {
            return price
        }
        return r3.stringValue
    }
    
    
    class func formatPriceF(priceF: CGFloat)->String{
        
        var hander:NSDecimalNumberHandler?
        
        if priceF >= 1000 {
            hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 3, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        }else if priceF >= 100 && priceF < 1000 {
            hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 4, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        }else if priceF >= 10 && priceF < 100 {
            hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 5, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        }else{
            hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 6, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        }
        
        let price:String = priceF.description
        
        let decimalprice = NSDecimalNumber.init(string: price)
        let decimalprice1 = NSDecimalNumber.init(string: "0")
        let r3 = decimalprice.adding(decimalprice1, withBehavior: hander)
        if r3.stringValue == "NaN" {
            return price
        }
        return r3.stringValue
    }
    
    //MARK:- price  打印效果 1位小数
    static func getStringPrice(price:String,priceF:Float)->String{
        var hander:NSDecimalNumberHandler?
        if priceF >= 10000000{
            hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 0, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        }else if priceF >= 1000000 && priceF < 10000000{
            hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 1, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        }else if priceF >= 100000 && priceF < 1000000{
            hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        }else if priceF >= 10000 && priceF < 100000 {
            hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 3, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        }else if priceF >= 1000 && priceF < 10000 {
            hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 4, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        }else if priceF >= 100 && priceF < 1000 {
            hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 5, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        }else if priceF >= 10 && priceF < 100 {
            hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 6, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        }else{
            hander = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 7, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        }
        
        let decimalprice = NSDecimalNumber.init(string: price)
        let decimalprice1 = NSDecimalNumber.init(string: "0")
        let r3 = decimalprice.adding(decimalprice1, withBehavior: hander)
        return r3.stringValue
    }
    
    
    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        free(result)
        return String(format: hash as String)
    }
    
    func cancleScientific()-> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        let number = formatter.number(from: self)
        if let n = number {
            //let lengthOfDecimal = self.split(separator: ".")[1].count
            if self.contains("E") || self.contains("e") || self.count > 15 {
                return String(format:"%.8f", n.doubleValue)
            }else {
                if number!.doubleValue <= Double(0.0) {
                    return "0"
                }
                return self
            }
        }else{
            return "0"
        }
    }
    
    //获取小数点位数
    func countOfPresicion()-> Int {
        let array = self.split(separator: ".")
        if array.count == 2 {
            let presicion = array[1]
            return presicion.count
        }
        return 0
    }
    
    func splitToIntArray(seperator: Character)-> [Int] {
        return self.split(separator: seperator).map({ (str) -> Int in
            return Int(str) ?? -1
        })
    }
    
    func getCoinAndQutoeCoinFromSymbol()->(String, String) {
        let coinPairArray = self.split(separator: "_")
        let coinName = String(coinPairArray[0])
        let coinQuote = String(coinPairArray[1])
        return (coinName, coinQuote)
    }
    
    func toLotteryNumberString()-> String {
        if let number = Int(self) {
            if number < 10 {
                return "0" + self
            }else {
                return self
            }
        }else {
            return "-1"
        }
    }
    //    func stringValue()-> String {
    //        if self == nil {
    //            return ""
    //        }else {
    //            return self
    //        }
    //    }
    
    
    func getHeightFixedWidth(fontSize:CGFloat,width:CGFloat,lineSpace : CGFloat)->CGFloat{
        
        let font = UIFont.systemFont(ofSize: fontSize)
        
        //        let size = CGSizeMake(width,CGFloat.max)
        
        let size = CGSize(width: width, height: CGFloat(MAXFLOAT))
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineSpacing = lineSpace
        
        paragraphStyle.lineBreakMode = .byWordWrapping;
        
        let attributes = [.font:font, NSAttributedString.Key.paragraphStyle :paragraphStyle.copy()]
        
        let text = self as NSString
        
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes, context:nil)
        
        return rect.size.height
        
    }//funcstringHeightWith
    
    
    func boundingRect(with constrainedSize: CGSize, font: UIFont, lineSpacing: CGFloat? = nil) -> CGSize {
        let attritube = NSMutableAttributedString(string: self)
        let range = NSRange(location: 0, length: attritube.length)
        attritube.addAttributes([NSAttributedString.Key.font: font], range: range)
        if lineSpacing != nil {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing!
            attritube.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
        }
        
        let rect = attritube.boundingRect(with: constrainedSize, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        var size = rect.size
        
        if let currentLineSpacing = lineSpacing {
            // 文本的高度减去字体高度小于等于行间距，判断为当前只有1行
            let spacing = size.height - font.lineHeight
            if spacing <= currentLineSpacing && spacing > 0 {
                size = CGSize(width: size.width, height: font.lineHeight)
            }
        }
        
        return size
    }
    
    func boundingRect(with constrainedSize: CGSize, font: UIFont, lineSpacing: CGFloat? = nil, lines: Int) -> CGSize {
        if lines < 0 {
            return .zero
        }
        
        let size = boundingRect(with: constrainedSize, font: font, lineSpacing: lineSpacing)
        if lines == 0 {
            return size
        }

        let currentLineSpacing = (lineSpacing == nil) ? (font.lineHeight - font.pointSize) : lineSpacing!
        let maximumHeight = font.lineHeight*CGFloat(lines) + currentLineSpacing*CGFloat(lines - 1)
        if size.height >= maximumHeight {
            return CGSize(width: size.width, height: maximumHeight)
        }
        
        return size
    }
    
    
    /// 计算文本的高度
    func getTextHeight(width: CGFloat) -> CGFloat {
        let size = CGSize(width: width, height: CGFloat(MAXFLOAT))
        return (self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [.font: UIFont.systemFont(ofSize: 16)], context: nil).size.height)
    }
    
    static func getTextHeightFixWidth(text:String,fontSize:CGFloat,width:CGFloat,lineSpace : CGFloat)->CGFloat{
        
        let font = UIFont.systemFont(ofSize: fontSize)
        
        //        let size = CGSizeMake(width,CGFloat.max)
        
        let size = CGSize(width: width, height: CGFloat(MAXFLOAT))
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineSpacing = lineSpace
        
        paragraphStyle.lineBreakMode = .byWordWrapping;
        
        let attributes = [.font:font, NSAttributedString.Key.paragraphStyle :paragraphStyle.copy()]
        
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes, context:nil)
        
        return rect.size.height
        
    }//funcstringHeightWith
    
    
    //MARK:- DegitailTransfer
    func doubleValue(decimalDigits:NSInteger) -> String{
        let formater = "%."+"\(decimalDigits)"+"lf"
        return String(format: formater, (self as NSString).doubleValue)
    }
    func floatValue(decimalDigits:NSInteger) -> String{
        let formater = "%."+"\(decimalDigits)"+"lf"
        return String(format: formater, (self as NSString).floatValue)
    }
    
    func integerValue() -> NSInteger{
        return (self as NSString).integerValue
    }
    
    func toInt() -> Int? {
        return Int(self)
    }
    
    func toFloat() -> Float? {
        return Float(self)
    }
    
    func toDouble() -> Double? {
        return Double(self)
    }
}

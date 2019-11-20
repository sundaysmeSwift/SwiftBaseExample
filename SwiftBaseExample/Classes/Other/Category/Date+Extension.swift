//
//  Date+Extension.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/6/15.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import Foundation

extension Date {
    
 /// 获取当前 秒级 时间戳 - 10位
    var timeStamp : String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return "\(timeStamp)"
    }

    /// 获取当前 毫秒级 时间戳 - 13位
    var millStamp : String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return "\(millisecond)"
    }

    
    static func timeStampStrToString(timeStamp:String, dateFormat:String = "yyyy-MM-dd HH:mm:ss")->String {
        let string = NSString(string: timeStamp)
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = dateFormat
        let date = NSDate(timeIntervalSince1970: timeSta)
        return dfmatter.string(from: date as Date)
    }
    
    static func millTimeStampStrToString(timeStamp:String, dateFormat:String = "yyyy-MM-dd HH:mm:ss")->String {
        let string = NSString(string: timeStamp)
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = dateFormat
        let date = NSDate(timeIntervalSince1970: timeSta/1000)
        return dfmatter.string(from: date as Date)
    }
    
    static func timeStampIntToString(timeStamp:TimeInterval, dateFormat:String = "yyyy-MM-dd HH:mm:ss")->String {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = dateFormat
        let date = NSDate(timeIntervalSince1970: timeStamp)
        return dfmatter.string(from: date as Date)
    }
    
    static func millTimeStampIntToString(timeStamp:TimeInterval, dateFormat:String = "yyyy-MM-dd HH:mm:ss")->String {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = dateFormat
        let date = NSDate(timeIntervalSince1970: timeStamp/1000)
        return dfmatter.string(from: date as Date)
    }
    
    func formatString(format: String)-> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = format   //"yyyyMMddHHmmss"
        let strNowTime = timeFormatter.string(from: self) as String
        return strNowTime
    }
    
    /// 判断某个时间是否为今年
    func isThisYear() -> Bool {
        let calender = Calendar.current
        //获得某个时间的年
        let yearComps = calender.component(Calendar.Component.year, from: self)
        let nowComps = calender.component(Calendar.Component.year, from: Date())
        return yearComps == nowComps;
    }
    
    /// 判断是否为昨天
    func isYesterday(formaterStr:String = "yyyy-MM-dd") -> Bool {
        var now = Date()
        //格式: 2017-06-15 21:46:00
        let fmt = DateFormatter()
        fmt.dateFormat = formaterStr
        //取得时间字符串
        let dateStr = fmt.string(from: self)
        //取得现在时间
        let nowStr = fmt.string(from: now)
        //取得的时间
        let date = fmt.date(from: dateStr)
        //现在时间
        now = fmt.date(from: nowStr)!
        let calender = Calendar.current
        let comps = calender.dateComponents([.year, .month, .day], from: date!, to: now)
        return comps.year == 0 && comps.month == 0 && comps.day == 1;
    }
    
    /// 判断是否为今天
    func isToday(formaterStr:String = "yyyy-MM-dd") -> Bool {
        let now = Date()
        let fmt = DateFormatter()
        fmt.dateFormat = formaterStr
        let dateStr = fmt.string(from: self)
        let nowStr = fmt.string(from: now)
        return dateStr == nowStr
    }
}


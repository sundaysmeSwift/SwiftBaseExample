//
//  UITableView+Extension.swift
//  News
//
//  Created by 杨蒙 on 2017/9/13.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit

/// --------------------- UITableView extension ---------------------
extension UITableView {
    ///注册cell
    func ym_registerCell<T: UITableViewCell>(cell: T.Type) where T: RegisterCellOrNib {
        if let xib = T.xib {
            // T 遵守了 RegisterCellOrNib 协议，所以通过 T 就能取出 identifier 这个属性
            register(xib, forCellReuseIdentifier: T.identifier)
        } else {
            register(cell, forCellReuseIdentifier: T.identifier)
        }
    }
    
    func ym_dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: RegisterCellOrNib {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
    ///注册HeaderFooter
    func ym_registerHeaderFooter<T: UITableViewHeaderFooterView>(headerFooter: T.Type) where T: RegisterCellOrNib {
        if let xib = T.xib {
            register(xib, forHeaderFooterViewReuseIdentifier: T.identifier)
        }else{
            register(headerFooter, forHeaderFooterViewReuseIdentifier: T.identifier)
        }
    }
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T where T: RegisterCellOrNib {
        return dequeueReusableHeaderFooterView(withIdentifier: T.identifier) as! T
    }
    
    class func defaultTableView(style: UITableView.Style) -> UITableView {
        let tableView = UITableView.init(frame: CGRect.zero, style: style)
        self.commonConfig(tableView: tableView)
        return tableView
    }
    class func defaultLineTableView(style: UITableView.Style, lineColor: UIColor = UIColor.init(hex: "#F5F5F5"), leftMarin: CGFloat = 10, rightMargin: CGFloat = 10) -> UITableView {
        let tableView = UITableView.init(frame: CGRect.zero, style: style)
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.backgroundColor = UIColor.white
        tableView.separatorColor = lineColor
        tableView.separatorInset = UIEdgeInsets.init(top: 0, left: leftMarin, bottom: 0, right: rightMargin)
        return tableView
    }
    class func commonConfig(tableView: UITableView) -> Void {
        
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
    }
    
    class func commonConfigLine(tableView: UITableView,lineColor: UIColor = UIColor.init(hex: "#F5F5F5"), leftMarin: CGFloat = 10, rightMargin: CGFloat = 10) -> Void {
        
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = lineColor
        tableView.separatorInset = UIEdgeInsets.init(top: 0, left: leftMarin, bottom: 0, right: rightMargin)
    }
}

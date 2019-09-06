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
}

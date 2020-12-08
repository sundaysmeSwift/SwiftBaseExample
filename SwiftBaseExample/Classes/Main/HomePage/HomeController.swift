//
//  HomeController.swift
//  SwiftBaseExample
//
//  Created by administrator on 2019/5/26.
//  Copyright © 2019 administrator. All rights reserved.
//

import Foundation
import UIKit

class HomeController: SQBaseTableViewVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("abdc".startIndex)
        
    }
    
    
    
    //MARK:- 监听
    func addObser(){
        NotificationCenter.default.addObserver(self, selector: #selector(notificationPwd(noti:)), name: NSNotification.Name(rawValue: "ud_pwd"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: Notification.Name.ud_refreshData, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: NSNotification.Name.ud_name, object: nil)
    }
    @objc func notificationPwd(noti:Notification) -> Void {
        
    }
    @objc func refreshData() -> Void {
        
    }
    func removeObser() -> Void {
        NotificationCenter.default.removeObserver(self)
    }
    deinit {
        self.removeObser()
    }

}



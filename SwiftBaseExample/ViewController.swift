//
//  ViewController.swift
//  SwiftBaseExample
//
//  Created by administrator on 2019/5/26.
//  Copyright © 2019 administrator. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    
//    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
//
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//
//    }
//    override func awakeFromNib() {
//        super.awakeFromNib()
//       
//    }
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)!
//        fatalError("init(coder:) has not been implemented")
//
//    }

//    convenience init(){
//        var nibNameOrNil = String?("ViewController")
//        if Bundle.main.path(forResource: nibNameOrNil, ofType: "xib") == nil {
//         nibNameOrNil = nil
//          }
//       self.init(nibName:nibNameOrNil, bundle: nil)
//       
//    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addObserver()
    }

    //MARK:- snpArr
    func layArrView() {
        let arrStr = ["在发现模块添加一个聊天模块，并在左上角显示内测版","只有白名单用户点击能进入聊天模块，其他客户点击弹出","搜索功能去掉。","用户建立群，只有该用户可以拉人入群，其他群员不能拉人进来","人入群，其他群员不能拉人进来"]
        let arrVs = arrStr.compactMap { (item) -> UILabel in
            let label = UILabel.init()
            label.numberOfLines = 0
            label.text = item
            
            label.backgroundColor = UIColor.green
            return label
        }
        for (i,sview) in arrVs.enumerated(){
            self.view.addSubview(sview)
        }
//        arrVs.snp.distributeDetermineWrapViews(verticalSpacing: 10, horizontalSpacing: 20, maxWidth: self.view.frame.width)
        arrVs.snp.distributeDetermineWrapViews(verticalSpacing: 10, horizontalSpacing: 20, maxWidth: self.view.frame.size.width, edgeInset: UIEdgeInsets(top: 50, left: 20, bottom: 20, right: 20), topConstrainView: nil, maskBourds: true, cornerRadio: 15)
    }
    
    //MARK:- 监听
    func addObser(){
        NotificationCenter.default.addObserver(self, selector: #selector(notificationMsg(notification:)), name: NSNotification.Name(rawValue: ud_Msg), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: Notification.Name.ud_refreshData, object: nil)
    }
    @objc func notificationMsg(notification:Notification) -> Void {
        
    }
    @objc func refreshData() -> Void {
        
    }
    func removeObser() -> Void {
        NotificationCenter.default.removeObserver(self)
    }
    deinit {
        self.removeObser()
    }
    
    //MARK:- refreshData
    func refreshRequestData(){
        self.requestData()
    }
    func requestData() {
        
    }
}


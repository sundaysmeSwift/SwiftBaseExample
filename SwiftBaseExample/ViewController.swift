//
//  ViewController.swift
//  SwiftBaseExample
//
//  Created by administrator on 2019/5/26.
//  Copyright © 2019 administrator. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON

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
        
        print("abcdef"[1...5])
    }

    func testSaveDicPlist(){
        let  myArray = [[["title":"基础必备","subTitle":"掌握基本常识","imgName":"h_nh_basic_ness"],["title":"交易必备","subTitle":"交易变得随心所欲","imgName":"h_nh_basic_trade"],["title":"产品介绍","subTitle":"了解更多知识","imgName":"h_nd_product_introduction"]],
                    [["question":"如何注册账号？" , "answer":"APP下载链接: https://www.quantbroker.info/ 复制网址浏览器打开—首页下拉到最后扫码下载"],
                    ["question":"如何实名认证？" , "answer":"登录APP-【我的】-【实名认证】-【选择自身对应的身份点击进入-填写姓名、身份证号、证件有效期（注：填写的信息一定要和身份证信息一致）-【提交】"],
                    ["question":"怎样场外交易？" , "answer":"登录账号-【发现】-【场外交易】-【同意第三方确认】-找到我要买-输入金额（人民币）-【买入】-【确认买入】-选择付款方式—确认金额—扫码转账/银行卡转账—转账成功后返回APP点击确认付款即可"],
                    ["question":"怎样币币交易？" , "answer":"登录账号—【交易】-【币至】-选择需要买入的币种-点击买入—可选择限价也可选择市价（限价：自己设定看好的价格，市价：按交易所最优的价格买）—输入购买数量—【买入】"],
                    ["question":"忘记登录密码？" , "answer":""],
                    ["question":"怎样币币交易？" , "answer":""]]
                ]
            
            
            let filePath:String = NSHomeDirectory() + "/Documents/tfDic.plist"
        NSArray(array: myArray).write(toFile: filePath, atomically: true)
            print(filePath)
            
            let tfArray = NSArray(contentsOfFile:NSHomeDirectory() + "/Documents/tfDic.plist")
            
        print(tfArray as Any)
    }

    func path() {
        let libraryPath:String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        print("library路径----\(libraryPath)")
        
        let cachePath:String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        print("Cache路径----\(cachePath)")
        
        let preferPath:String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.preferencePanesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        print("Prefer路径----\(preferPath)")
        
        let homeDir:String = NSHomeDirectory()
        print("沙盒地址---\(homeDir)")

        let imagePath = Bundle.main.path(forResource: "sale", ofType: "png")!
        print("FlyElephnt-图片路径----\(imagePath)")
        
        let bundlePath = Bundle.main.bundleURL.path
        print("FlyElephnt-App资源文件路径--\(bundlePath)")
        
        let testDataPath = Bundle.main.bundleURL.appendingPathComponent("FlyElephant").path
        print("压缩文件的路径---\(testDataPath)")
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
        NotificationCenter.default.addObserver(self, selector: #selector(notificationMsg(notification:)), name: Notification.Name.ud_Msg, object: nil)
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
        apiProvider.request(.getUserLogin) { (result) -> () in
            switch result {
            case let .success(response):
                response.data.toJSON().processResponse(status: response.statusCode) { (json) in
                let dataArray = json["data"].arrayValue;
                }
            case let .failure(error):
                print(error)
            }
        }
        
        
        
        apiProvider.request(.register(country: "", mobile: "", pwd: "", verifycode: "")) { (result) -> Void in
            switch result {
            case let .success(response):
                response.data.toJSON().processResponse(status: response.statusCode) { (json) in
                let dataArray = json["data"].arrayValue;
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}


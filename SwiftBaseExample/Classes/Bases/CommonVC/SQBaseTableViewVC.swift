//
//  SecondViewController.swift
//  SwiftBaseExample
//
//  Created by 曹亮亮 on 2019/9/10.
//  Copyright © 2019 administrator. All rights reserved.
//

import UIKit
//import MJRefresh

class SQBaseTableViewVC: UIViewController {
    
    
    private lazy var tableView:UITableView = {
        let tableView = UITableView.defaultLineTableView(style: .grouped)
        tableView.separatorColor = UIColor.red
        tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = UIColor.white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)")
        
        tableView.delegate = self;
        tableView.dataSource = self;
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        return tableView
    }()
    
    
    
    func setUpUI() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        
        self.tableView.frame = self.view.frame
        self.tableView.reloadData()
        //        self.tableView.snp.makeConstraints { (make) in
        //            make.edges.equalTo(view)
        //        }
        //        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
        //
        //        })
        //        self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { [weak self] in
        //
        //        })
        //        if UserManager.shared.isLoginStatus {
        //            self.tableView.mj_header.beginRefreshing()
        //        }
    }
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let str2 = decimalString(string: "\(Myview.self)")
        
        print(str2)
        
        setUpUI()
    }
    
    
    //MARK:- 消除浮动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.tableView  {
            let sectionHeaderHeight = CGFloat(50)
            if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
                scrollView.contentInset = UIEdgeInsets.init(top: -scrollView.contentOffset.y, left: 0, bottom: 0, right: 0);
            } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
                scrollView.contentInset = UIEdgeInsets.init(top: -sectionHeaderHeight, left: 0, bottom: 0, right: 0);
            }
        }
    }
    
    

    
}



//MARK:- UITableViewDataSource UITableViewDelegate
extension SQBaseTableViewVC: UITableViewDelegate, UITableViewDataSource{
    //MARK:- UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "\(UITableViewCell.self)", for: indexPath)
        cell?.textLabel?.text = "你好"
        cell?.selectionStyle = .none
        
//        cell?.separatorInset = UIEdgeInsets.zero
//        cell?.layoutMargins = UIEdgeInsets.zero
//        cell?.separatorInset = UIEdgeInsets.init(top: 0, left: 16, bottom: 0, right: 16)
//        cell?.layoutMargins = UIEdgeInsets.init(top: 0, left: 16, bottom: 0, right: 16)
        
        
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init()
    }
    
    //MARK: UITableViewDelegate
    // 设置cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0.001
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    // 选中cell后执行此方法
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

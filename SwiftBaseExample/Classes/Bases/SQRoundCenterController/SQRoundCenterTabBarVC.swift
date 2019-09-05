//
//  SQRoundCenterTabBarVC.swift
//  SwiftBaseExample
//
//  Created by administrator on 2019/5/27.
//  Copyright © 2019 administrator. All rights reserved.
//

import Foundation
import UIKit

class SQRoundCenterTabBarVC: UITabBarController {
    override func viewDidLoad() {
        let tabBar = SQTabBar.init()
        //1
        tabBar.buttonClickBlock = {[weak self] (button)->() in
            self?.puslishBtnClick(button: button)
        }
        //2
        tabBar.centerBtnClick { [weak self](button) in
            self?.puslishBtnClick(button: button)
        }
        self.setValue(tabBar, forKey: "tabBar")
        //UI
        initUI()
        self.selectedIndex = 0
        //Custome TabBar
        
    }
    func initUI() {
        //1
        addChildController(ChildController: HomeController(), Title: "首页", DefaultImage: UIImage(named:"home_nor")!, SelectedImage: UIImage(named:"home_sel")!)
        addChildController(ChildController: SecondController(), Title: "分类", DefaultImage: UIImage(named:"class_nor")!, SelectedImage: UIImage(named:"class_sel")!)
        addChildController(ChildController: ThreeController(), Title: "购物车", DefaultImage: UIImage(named:"shoppingCar_nor")!, SelectedImage: UIImage(named:"shoppingCar_sel")!)
        addChildController(ChildController: MeController(), Title: "我的", DefaultImage: UIImage(named:"center_nor")!, SelectedImage: UIImage(named:"center_sel")!)
        
        //2
        addChildVC(ChildController: HomeController(), Title: "首页", DefaultImage: "home_nor", SelectedImage: "home_sel")
        addChildVC(ChildController: HomeController(), Title: "第二页", DefaultImage: "second_nor", SelectedImage: "second_sel")
        addChildVC(ChildController: HomeController(), Title: "第三页", DefaultImage: "second_nor", SelectedImage: "second_sel")
        addChildVC(ChildController: HomeController(), Title: "第四页", DefaultImage: "second_nor", SelectedImage: "second_sel")
        //3
        addChildVCByType(ChildControllerCls: HomeController.self, Title: "首页", DefaultImage: "home_nor", SelectedImage: "home_sel")
        addChildVCByType(ChildControllerCls: SecondController.self, Title: "首页", DefaultImage: "home_nor", SelectedImage: "home_sel")
        addChildVCByType(ChildControllerCls: ThreeController.self, Title: "首页", DefaultImage: "home_nor", SelectedImage: "home_sel")
        addChildVCByType(ChildControllerCls: MeController.self, Title: "首页", DefaultImage: "home_nor", SelectedImage: "home_sel")
    }
    
    func addChildController(ChildController child:UIViewController, Title title:String, DefaultImage defaultImage:UIImage, SelectedImage selectedImage:UIImage){
        child.tabBarItem = UITabBarItem(title: title, image: defaultImage.withRenderingMode(.alwaysOriginal), selectedImage: selectedImage.withRenderingMode(.alwaysOriginal))
        child.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.black], for: .selected)
        
        let nav = SQBaseNavigationController(rootViewController: child)
        nav.setNavigationBarHidden(true, animated: true)
        self.addChild(nav)
    }
    func addChildVC(ChildController child:UIViewController, Title title:String, DefaultImage defaultImage:String, SelectedImage selectedImage:String){
        child.tabBarItem = UITabBarItem(title: title, image: UIImage.sq_ImageNameWithOriginMode(imageName: defaultImage), selectedImage: UIImage.sq_ImageNameWithOriginMode(imageName: selectedImage))
        child.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.black], for: .selected)
        
        let nav = SQBaseNavigationController(rootViewController: child)
        nav.setNavigationBarHidden(true, animated: true)
        self.addChild(nav)
    }
    //T.type
    func addChildVCByType<T:UIViewController>(ChildControllerCls childCls:T.Type, Title title:String, DefaultImage defaultImage:String, SelectedImage selectedImage:String){
        let child = childCls.init()
        
        child.tabBarItem = UITabBarItem(title: title, image: UIImage.sq_ImageNameWithOriginMode(imageName: defaultImage), selectedImage: UIImage.sq_ImageNameWithOriginMode(imageName: selectedImage))
        child.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.black], for: .selected)
        
        let nav = SQBaseNavigationController(rootViewController: child)
        nav.setNavigationBarHidden(true, animated: true)
        self.addChild(nav)
    }
//    //MARK - centBtnClick
    func puslishBtnClick(button: UIButton) {
        DispatchQueue.global().async {
//            DispatchQueue.main.async {
//
//            }
            DispatchQueue.global().async(execute: {
                
            })
        }
    }
}

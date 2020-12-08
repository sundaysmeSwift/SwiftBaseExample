//
//  SQTabbar.swift
//  SwiftBaseExample
//
//  Created by administrator on 2019/5/26.
//  Copyright © 2019 administrator. All rights reserved.
//

import Foundation
import UIKit

typealias ClickCenterBtn = (_ button: UIButton)->Void
let btnWidth: CGFloat = 80
let arcRadio: CGFloat = btnWidth / 2.0

class SQTabBar: UITabBar {
    
    var buttonClickBlock:ClickCenterBtn?
    
    var centerBtn: UIButton = {
        let btn = UIButton(type: .custom)
        ////////
        btn.setImage(UIImage.sq_ImageScaleToSize(Image: (UIImage(named: "")?.withRenderingMode(.alwaysOriginal))!, ScaleToSize: CGSize(width: btnWidth, height: btnWidth)), for: .normal)
        ///////
        btn.setImage(UIImage.sq_ImageNameWithOriginModeAndScaleSize(ImageName: "", ScaleToSize: CGSize(width: btnWidth, height: btnWidth)), for: .selected)
        
        btn.sizeToFit()
//        btn.addTarget(self, action: #selector(clickCenterBtn(button:)), for: .touchUpInside)
        btn.addTarget(self, action: #selector(centerBtnClick(shareClick:)), for: .touchUpInside)
        return btn
    }()
    //平常写法
    @objc func clickCenterBtn(button: UIButton) {
        if (self.buttonClickBlock != nil) {
            self.clickCenterBtn(button: button)
        }
    }
    //MARK - centBtnClick 逃逸闭包写法
    @objc func centerBtnClick(shareClick:@escaping(_ button: UIButton)->())->() {
        DispatchQueue.global().async {
            //            DispatchQueue.main.async {
            //
            //            }
            DispatchQueue.main.async(execute: {
                shareClick(self.centerBtn)
            })
        }
    }
    
    override func layoutSubviews() {
        let width = self.bounds.size.width/CGFloat(self.items!.count + 1)
        let height = TABBAR_HEIGHT
        let xOrigin: CGFloat = 0
        var index = 0
        for subView in self.subviews {
            if (subView.isKind(of: NSClassFromString("UITabBarButton")!))
            {
                if (index == 2) {
                    index += 1
                }
                subView.frame = CGRect(x:xOrigin + width * CGFloat(index) , y:0 , width: width, height: height)
                //subView.frame.origin.y
                index += 1
            }
        }
        self.centerBtn.center = CGPoint(x: self.bounds.size.width * 0.5, y: height * 0.5)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.clipsToBounds || self.isHidden || self.alpha == 0 {
            return nil
        }
        var result = super.hitTest(point, with: event)
        //如果时间发生
        if result != nil {
            return result
        }
        // 这里遍历那些超出的部分就可以了，不过这么写比较通用。
        for subView in self.subviews {
            // 把这个坐标从tabbar的坐标系转为 subview 的坐标系
            let subPoint = subView.convert(point, from: self)
            result = subView.hitTest(subPoint, with: event)
            // 如果事件发生在 subView 里就返回
            if (result != nil) {
                return result;
            }
        }
        return nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isTranslucent = false
        self.configTabBar()
        self.addSubview(centerBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if self.isHidden == false {
            let circlePath  = UIBezierPath.init(arcCenter: self.centerBtn.center, radius: arcRadio, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
            let tabbarPath = UIBezierPath.init(rect: self.bounds)
            if circlePath.contains(point) || tabbarPath.contains(point) {
                return true
            }
            return false
        } else {
            return super.point(inside: point, with: event)
        }
    }
    //MARK - UIBatBar
    func configTabBar(){
        let tabbarItem = UITabBarItem.appearance()
        let attrNor = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: TABBAR_FONT), NSAttributedString.Key.foregroundColor : TABBAR_COLOR_NOR]
        let attrSel = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: TABBAR_FONT), NSAttributedString.Key.foregroundColor : TABBAR_COLOR_SEL]
        tabbarItem .setTitleTextAttributes(attrNor, for: .normal)
        tabbarItem .setTitleTextAttributes(attrSel, for: .selected)
        
        UITabBar.appearance().backgroundColor = UIColor.white
    }
}

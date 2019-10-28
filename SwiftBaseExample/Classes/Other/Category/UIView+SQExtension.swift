//
//  UIViewSQExtension.swift
//  SwiftExample
//
//  Created by 曹亮亮 on 2019/9/5.
//  Copyright © 2019 曹亮亮. All rights reserved.
//

import UIKit


extension UIView {
    func setShadow(shadowColor: CGColor, shadowOpacity: Float, shadowOffset: CGSize, shadowRadius: CGFloat) {
        self.layer.shadowColor = shadowColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
    }
    // MARK: - UI-Get
    func top()-> CGFloat {
        return self.frame.minY
    }
    func bottom()-> CGFloat {
        return self.frame.maxY
    }
    func right()-> CGFloat {
        return self.frame.maxX
    }
    func left()-> CGFloat {
        return self.frame.minX
    }
    
    // MARK: - UI-Set
    func setX(x: CGFloat) {
        self.frame = CGRect(x: x, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.height)
    }
    func setY(y: CGFloat) {
        self.frame = CGRect(x: self.frame.origin.x, y: y, width: self.frame.size.width, height: self.frame.height)
    }
    func setWidth(width: CGFloat) {
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: width, height: self.frame.height)
    }
    func setHeight(height: CGFloat) {
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: height)
    }
    
    
    //MARK:- loadfromnib
    class func loadFromNibNamed(nibNamed: String, bundle : Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }

    func addSeparatorBottomLine(lMargin:Float = 14,rMargin:Float = 14,hegiht:Float = 0.5,lineColor:UIColor = ThemeColor.sharedInstance.getLineViewColor())-> UIView {

        let lineView = UIView(frame: CGRect.init())
        lineView.backgroundColor = lineColor
        self.addSubview(lineView)
        lineView.snp_makeConstraints { (make) in
            make.left.equalToSuperview().offset(lMargin)
            make.right.equalToSuperview().offset(-rMargin)
            make.height.equalTo(0.5)
            make.bottom.equalTo(0)
        }
        return lineView
    }
    
    func addSeparatorTopLine(lMargin:Float = 14,rMargin:Float = 14,hegiht:Float = 0.5,slineColor:UIColor = lineColor,bMargin:Float = 0)-> UIView {
        
        let lineView = UIView(frame: CGRect.init())
        lineView.backgroundColor = slineColor
        self.addSubview(lineView)
        lineView.snp_makeConstraints { (make) in
            make.left.equalToSuperview().offset(lMargin)
            make.right.equalToSuperview().offset(-rMargin)
            make.height.equalTo(0.5)
            make.top.equalToSuperview().offset(bMargin)
        }
        return lineView
    }

    
    func addSeparatorBottomLine(lMargin:Float = 14,rMargin:Float = 14,hegiht:Float = 0.5,slineColor:UIColor = lineColor,tMargin:Float = 0)-> UIView {

        let lineView = UIView(frame: CGRect.init())
        lineView.backgroundColor = slineColor
        self.addSubview(lineView)
        lineView.snp_makeConstraints { (make) in
            make.left.equalToSuperview().offset(lMargin)
            make.right.equalToSuperview().offset(-rMargin)
            make.height.equalTo(0.5)
            make.bottom.equalToSuperview().offset(-tMargin)
        }
        return lineView
    }
    
}




public protocol NibLoadable {
}
extension NibLoadable where Self : UIView {
    //在协议里面不允许定义class 只能定义static
    static func loadFromNib(_ nibname: String? = nil) -> Self {//Self (大写) 当前类对象
        //self(小写) 当前对象
        let loadName = nibname == nil ? "\(self)" : nibname!
//        let nib = UINib(nibName: nibName, bundle: nil)
//        return nib.instantiate(withOwner: self, options: nil).first as! Self
        return Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)?.first as! Self
    }
}
extension NibLoadable where Self : UIViewController {
    //在协议里面不允许定义class 只能定义static
    static func loadFromNib(_ nibname: String? = nil) -> Self {//Self (大写) 当前类对象
        //self(小写) 当前对象
        let loadName = nibname == nil ? "\(self)" : nibname!
        //        let nib = UINib(nibName: nibName, bundle: nil)
        //        return nib.instantiate(withOwner: self, options: nil).first as! Self
        return Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)?.first as! Self
    }
}

/// --------------------- Cell extension ---------------------
protocol RegisterCellOrNib {
}

extension RegisterCellOrNib where Self: UIView {
    static var identifier: String {
        return "\(self)"
    }
    
    static var xib: UINib? {
        return UINib(nibName: "\(self)", bundle: nil)
    }
}


//MARK: - 仿命名空间
// 定义一个protocol -> NamespaceWrappable,含有关联属性： hand【关联类型(HandWrapperType)】
public protocol MajqNamespaceProtocal {
    
    //关联类型
    associatedtype HandWrapperType
    
    //关联属性: 实例属性
    var majq: HandWrapperType { get }
    
    //关联属性： 类 属性
    static var majq: HandWrapperType.Type { get }
    
}

//扩展协议 NamespaceWrappable
public extension MajqNamespaceProtocal {
    //实现协议： 属性majq类型为：MajqNamespaceStruct<Self>，get 方法 返回NamespaceWrapper<Self> 实例对象
    //btn.majq 返回值类型为：MajqNamespaceStruct<UIButton> 具体看：https://www.jianshu.com/p/5059d2993509
    var majq: MajqNamespaceStruct<Self> {
        return MajqNamespaceStruct(value: self)
    }
    
    //类方法
    static var majq: MajqNamespaceStruct<Self>.Type {
        return MajqNamespaceStruct.self
    }
    
    
}

//NSObject类实现这个协议（任何一个NSObject 类都可以含有属性 majq）
///已默认 NSObject 类及其子类实现，需要添加其他的方法使用 where 匹配模式扩展
///如下面： mcApplyAppearance 方法
extension NSObject: MajqNamespaceProtocal {
    
}

//String 实现这个MajqNamespaceProtocal协议
extension String: MajqNamespaceProtocal {
    
}





//结构体：NamespaceWrapper【结构体能用于 范型 类型】
public struct MajqNamespaceStruct<T> {
    
    //属性：wrappedValue 类型为范型T
    public let wrappedValue: T
    
    //初始化方法，参数类型为范型T
    public init(value: T) {
        self.wrappedValue = value
    }
}
//MARK: - 用法

//为 String拓展一个方法
extension MajqNamespaceStruct where T == String {
    var majqTest: String {
        return wrappedValue
    }
    
}


//由于 namespace 相当于将原来的值做了封装,所以如果在写扩展方法时需要用到原来的值,就不能再使用self,而应该使用wrappedValue
public extension MajqNamespaceStruct where T: UIView {
    
    /// 默认的 UI 控件外形设置通用方法
    ///
    /// - Parameter settings: 一个包含外形设置代码的闭包: 参数为范型T，返回值Void
    /// - Returns: UIView自身实例
    @discardableResult
    func mcApplyAppearance(_ settings: (_ v: T) -> Void) -> T {
        settings(wrappedValue)  //wrappedValue 是协议 MajqNamespaceStruct 本身的属性，可以直接使用
        return wrappedValue
    }
    
    
}

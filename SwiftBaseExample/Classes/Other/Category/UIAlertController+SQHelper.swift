//
//  UIAlertController+SQHelper.swift
//  ExmapleTest
//
//  Created by administrator on 2019/9/15.
//  Copyright © 2019 administrator. All rights reserved.
//

import UIKit

enum SQDataType {
    case sqNone
    case sqStr
    case sqImage
    case sqInImageName
    case sqoutImage
}

extension UIAlertAction {
    fileprivate struct AssociatedKeys
    {
        //按钮title的颜色
        static var textColor: UIColor = UIColor.blue
        //
    }
    
    var textColor: UIColor?{
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.textColor) as! UIColor)
        }
        set {
            var count: uint = 0
            let ivars = class_copyIvarList(UIAlertAction.self, &count)
            for i in 0..<count {
                let ivar = ivars![Int(i)]
                let name = ivar_getName(ivar)
                if let ivarName: String = String.init(cString: name!){
                    if ivarName == "_titleTextColor" {
                        self.setValue(newValue, forKey: "titleTextColor")
                    }
                    
                }
            }
            free(ivars)
            objc_setAssociatedObject(self, &AssociatedKeys.textColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension UIAlertController{
    
    
    // MARK: - 设置属性
    fileprivate struct AssociatedKeys
    {
        //统一按钮颜色，默认蓝色
        static var tintColor:UIColor = UIColor.blue
        //标题颜色
        static var titleColor: UIColor = UIColor.white
        //信息颜色
        static var msgColor: UIColor = UIColor.blue
        //标题大小
        static var titleFontSize: CGFloat = 16
        //提示大小
        static var msgFontSize: CGFloat = 12
    }
    
    var tintColor: UIColor?{
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.tintColor) as? UIColor)
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.tintColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var titleColor: UIColor?{
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.titleColor) as? UIColor)
        }
        set {
//            var count: uint = 0
//            let ivars = class_copyIvarList(UIAlertController.self, &count)
//            for i in 0..<count {
//                let ivar = ivars![Int(i)]
//                let name = ivar_getName(ivar)
//                let ivarName: String = String.init(cString: name!)
//                print(ivarName)
//                if ivarName == "_attributedTitle" && (self.title != nil) && (self.titleColor != nil){
//                    let attr: NSAttributedString = NSAttributedString.init(string: self.title!, attributes: [.foregroundColor : newValue as Any, .font : UIFont.systemFont(ofSize: 14)])
//                    self.setValue(attr, forKey: "attributedTitle")
//                }
//            }
//            free(ivars)
            objc_setAssociatedObject(self, &AssociatedKeys.titleColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var msgColor: UIColor?{
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.msgColor) as? UIColor)
        }
        set {
//            var count: uint = 0
//            let ivars = class_copyIvarList(UIAlertController.self, &count)
//            for i in 0..<count {
//                let ivar = ivars![Int(i)]
//                let name = ivar_getName(ivar)
//                let ivarName: String = String.init(cString: name!)
//                if ivarName == "_attributedMessage" && (self.message != nil) && (self.msgColor != nil){
//                    let attr: NSAttributedString = NSAttributedString.init(string: self.message!, attributes: [.foregroundColor : newValue as Any, .font : UIFont.systemFont(ofSize: 14)])
//                    self.setValue(attr, forKey: "attributedMessage")
//                }
//            }
//            free(ivars)
            objc_setAssociatedObject(self, &AssociatedKeys.msgColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var titleFontSize: CGFloat? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.titleFontSize, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.titleFontSize) as? CGFloat)
        }
    }
    
    var msgFontSize: CGFloat? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.msgFontSize, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.msgFontSize) as? CGFloat)
        }
    }
    
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        var count: uint = 0
        let ivars = class_copyIvarList(UIAlertController.self, &count)
        for i in 0..<count {
            let ivar = ivars![Int(i)]
            let name = ivar_getName(ivar)
            let ivarName: String = String.init(cString: name!)
            print(ivarName)
            if ivarName == "_attributedTitle" && (self.title != nil) && (self.titleColor != nil){
                let titleFont = self.titleFontSize != nil ? UIFont.systemFont(ofSize: self.titleFontSize!) : UIFont.systemFont(ofSize: AssociatedKeys.titleFontSize)
                let attr: NSAttributedString = NSAttributedString.init(string: self.title!, attributes: [.foregroundColor : self.titleColor as Any, .font : titleFont])
                self.setValue(attr, forKey: "attributedTitle")
            }

            if ivarName == "_attributedMessage" && (self.message != nil) && (self.msgColor != nil){
                let titleFont = self.titleFontSize != nil ? UIFont.systemFont(ofSize: self.msgFontSize!) : UIFont.systemFont(ofSize: 12)
                let attr: NSAttributedString = NSAttributedString.init(string: self.message!, attributes: [.foregroundColor : self.msgColor as Any, .font : UIFont.systemFont(ofSize: AssociatedKeys.msgFontSize)])
                self.setValue(attr, forKey: "attributedMessage")
            }
        }
        free(ivars)

        
        if let stintColor = self.titleColor {
            for alertAction in self.actions {
                if alertAction.style != .destructive {
                    alertAction.textColor = stintColor
                }
            }
        }
    }
    
    
    
    // MARK: - 快捷方法
    //创建样式
    static func showAlert(title: String,titleFontSize: CGFloat = 16,titleColor: UIColor = UIColor.black,message:String, msgColor: UIColor = UIColor.black, btnColor: UIColor = UIColor.blue, msgFontSize: CGFloat = 14, in viewController:UIViewController, alertStyle: UIAlertController.Style = .alert){
        let alertVC = UIAlertController(title: nil, message: message, preferredStyle: alertStyle)
        alertVC.title = title
        alertVC.titleColor = titleColor
        alertVC.titleFontSize = titleFontSize
        
        alertVC.message = message
        alertVC.msgColor = msgColor
        alertVC.msgFontSize = msgFontSize
        alertVC.tintColor = btnColor
        alertVC.addAction(UIAlertAction(title: NSLocalizedString("确定", comment: "确定"), style: .default, handler: nil))
        viewController.present(alertVC, animated: true, completion: nil)
    }
    //指定样式播放视图
    static func showAlert(title: String,titleFontSize: CGFloat = 16,titleColor: UIColor = UIColor.black,message: String, msgColor: UIColor = UIColor.black, btnColor: UIColor = UIColor.blue, msgFontSize: CGFloat = 15, alertStyle: UIAlertController.Style = .alert) {
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            showAlert(title: title, titleFontSize: titleFontSize, titleColor: titleColor,message: message, msgColor: msgColor,btnColor: UIColor.blue, msgFontSize: msgFontSize, in: vc, alertStyle: alertStyle)
        }
    }
    //创建样式
    static func ShowConfirm(title: String,titleFontSize: CGFloat = 16,titleColor: UIColor = UIColor.black,messgae:String, msgColor: UIColor = UIColor.black, msgFontSize: CGFloat = 15, btnConfirmTextColor:UIColor = UIColor.blue,btnCancleTextColor:UIColor = UIColor.blue, alertStyle: UIAlertController.Style = .alert, in viewController:UIViewController,confirmBlock:((UIAlertAction)->Void)?){
        let alertVC = UIAlertController(title: nil, message: messgae, preferredStyle: alertStyle)
        alertVC.title = title
        alertVC.titleColor = titleColor
        alertVC.titleFontSize = titleFontSize
        
        alertVC.message = messgae
        alertVC.msgColor = msgColor
        alertVC.msgFontSize = msgFontSize
        let confrimAction: UIAlertAction = UIAlertAction(title: NSLocalizedString("取消", comment: "取消"), style: .default, handler: nil)
        confrimAction.textColor = btnConfirmTextColor
        
        let cancleAction : UIAlertAction = UIAlertAction(title: NSLocalizedString("确定", comment: "确定"), style: .default, handler: confirmBlock)
        cancleAction.textColor = btnCancleTextColor
        
        alertVC.addAction(confrimAction)
        alertVC.addAction(cancleAction)
        viewController.present(alertVC, animated: true, completion: nil)
    }
    //指定播放样式的视图和确定按钮的动作
    static func showConfirm(title: String,titleFontSize: CGFloat = 16,titleColor: UIColor = UIColor.black,message:String, msgColor: UIColor = UIColor.black, msgFontSize: CGFloat = 15, btnConfirmTextColor:UIColor = UIColor.blue,btnCancleTextColor:UIColor = UIColor.blue, alertStyle: UIAlertController.Style = .alert,confirmBlock:((UIAlertAction)->Void)?){
        if let vc = UIApplication.shared.keyWindow?.rootViewController{
            ShowConfirm(title: title, titleFontSize: titleFontSize, titleColor: titleColor,messgae: message, msgColor: msgColor, msgFontSize: msgFontSize, btnConfirmTextColor: btnConfirmTextColor, btnCancleTextColor: btnCancleTextColor, alertStyle: alertStyle, in: vc, confirmBlock: confirmBlock)
        }
    }
    
    //指定多个
    static func showAlert(title: String,titleFontSize: CGFloat = 16,titleColor: UIColor = UIColor.black, msg: String,msgFontSize: CGFloat = 15,msgColor: UIColor = UIColor.black,btnDefautTextArray: Array<String>?, btnDefautTextColor:UIColor = UIColor.blue,btnCancleTextArray: Array<String>? = [], btnCancleTextColor:UIColor = UIColor.blue, btnDestructTextArray: Array<String>? = [],btnDestructTextColor: UIColor = UIColor.red,alertStyle: UIAlertController.Style = .alert,in viewController:UIViewController,confirmBlock:@escaping ((UIAlertAction?,String?,NSInteger?)->(Void)),cancleBlock:@escaping (((UIAlertAction?,String?,NSInteger?)->(Void))),destructBlock:@escaping ((UIAlertAction?,String?,NSInteger?)->(Void))){
        
        let alertVC = UIAlertController(title: nil, message: msg, preferredStyle: alertStyle)
        alertVC.title = title
        alertVC.titleColor = titleColor
        alertVC.titleFontSize = titleFontSize
        alertVC.message = msg
        alertVC.msgColor = msgColor
        alertVC.msgFontSize = msgFontSize

        for (index, str) in (btnDefautTextArray?.enumerated())! {
            let confrimAction: UIAlertAction = UIAlertAction(title: NSLocalizedString(str, comment: str), style: .default, handler: { (alertAction) in
                
                confirmBlock(alertAction,str,index)
            })
            confrimAction.textColor = btnDefautTextColor
            alertVC.addAction(confrimAction)
        }
        
        for (index, str) in (btnCancleTextArray?.enumerated())! {
            let cancleAction: UIAlertAction = UIAlertAction(title: NSLocalizedString(str, comment: str), style: .cancel, handler: { (alertAction) in
                
                cancleBlock(alertAction,str,index)
            })
            cancleAction.textColor = btnCancleTextColor
            alertVC.addAction(cancleAction)
        }
        
        for (index, str) in (btnDestructTextArray?.enumerated())! {
            let destructAction: UIAlertAction = UIAlertAction(title: NSLocalizedString(str, comment: str), style: .destructive, handler: { (alertAction) in
                
                destructBlock(alertAction,str,index)
            })
            destructAction.textColor = btnDestructTextColor
            alertVC.addAction(destructAction)
        }
        viewController.present(alertVC, animated: true, completion: nil)
    }
    
    //指定多个
    static func showAlert(title: String,titleFontSize: CGFloat = 16,titleColor: UIColor = UIColor.black, msg: String,msgFontSize: CGFloat = 15,msgColor: UIColor = UIColor.black,btnDefautTextArray: Array<String>?, btnDefautTextColor:UIColor = UIColor.blue,btnCancleTextArray: Array<String>? = [], btnCancleTextColor:UIColor = UIColor.blue, btnDestructTextArray: Array<String>? = [],btnDestructTextColor: UIColor = UIColor.red,alertStyle: UIAlertController.Style = .alert,confirmBlock:@escaping ((UIAlertAction?,String?,NSInteger?)->(Void)),cancleBlock:@escaping (((UIAlertAction?,String?,NSInteger?)->(Void))),destructBlock:@escaping ((UIAlertAction?,String?,NSInteger?)->(Void))){
        if let vc = UIApplication.shared.keyWindow?.rootViewController{
            showAlert(title: title, titleFontSize: titleFontSize, titleColor: titleColor, msg: msg, msgFontSize: msgFontSize, msgColor: msgColor, btnDefautTextArray: btnDefautTextArray, btnDefautTextColor: btnDefautTextColor, btnCancleTextArray: btnCancleTextArray, btnCancleTextColor: btnCancleTextColor, btnDestructTextArray: btnDestructTextArray, btnDestructTextColor: btnDestructTextColor, alertStyle: alertStyle, in: vc, confirmBlock: confirmBlock, cancleBlock: cancleBlock, destructBlock: destructBlock)
        }
        
    }
    
    static func showAlert(title: String ,titleFontSize: CGFloat = 16,titleColor: UIColor = UIColor.black, msg: String,msgFontSize: CGFloat = 15,msgColor: UIColor = UIColor.black,btnDefautTextArray: Array<String>?, btnCancleTextArray: Array<String>? = [], btnDestructTextArray: Array<String>? = [],btnTintColor: UIColor = UIColor.blue, btnDestructTextColor: UIColor = UIColor.red,alertStyle: UIAlertController.Style = .alert,in viewController:UIViewController,confirmBlock:@escaping ((UIAlertAction?,String?,NSInteger?)->(Void)),cancleBlock:@escaping (((UIAlertAction?,String?,NSInteger?)->(Void))),destructBlock:@escaping ((UIAlertAction?,String?,NSInteger?)->(Void))){
        
        let alertVC = UIAlertController(title: nil, message: msg, preferredStyle: alertStyle)
        alertVC.title = title
        alertVC.titleColor = titleColor
        alertVC.titleFontSize = titleFontSize
        alertVC.message = msg
        alertVC.msgColor = msgColor
        alertVC.msgFontSize = msgFontSize
        
        for (index, str) in (btnDefautTextArray?.enumerated())! {
            let confrimAction: UIAlertAction = UIAlertAction(title: NSLocalizedString(str, comment: str), style: .default, handler: { (alertAction) in
                
                confirmBlock(alertAction,str,index)
            })
            confrimAction.textColor = btnTintColor
            alertVC.addAction(confrimAction)
        }
        
        for (index, str) in (btnCancleTextArray?.enumerated())! {
            let cancleAction: UIAlertAction = UIAlertAction(title: NSLocalizedString(str, comment: str), style: .cancel, handler: { (alertAction) in
                
                cancleBlock(alertAction,str,index)
            })
            cancleAction.textColor = btnTintColor
            alertVC.addAction(cancleAction)
        }
        
        for (index, str) in (btnDestructTextArray?.enumerated())! {
            let destructAction: UIAlertAction = UIAlertAction(title: NSLocalizedString(str, comment: str), style: .destructive, handler: { (alertAction) in
                
                destructBlock(alertAction,str,index)
            })
            destructAction.textColor = btnDestructTextColor
            alertVC.addAction(destructAction)
        }
        viewController.present(alertVC, animated: true, completion: nil)
    }
    
    //指定多个
    static func showAlert(title: String,titleFontSize: CGFloat = 16,titleColor: UIColor = UIColor.black, msg: String,msgFontSize: CGFloat = 15,msgColor: UIColor = UIColor.black,btnDefautTextArray: Array<String>?, btnCancleTextArray: Array<String>? = [], btnDestructTextArray: Array<String>? = [],btnTintColor: UIColor = UIColor.blue, btnDestructTextColor: UIColor = UIColor.red,alertStyle: UIAlertController.Style = .alert,confirmBlock:@escaping ((UIAlertAction?,String?,NSInteger?)->(Void)),cancleBlock:@escaping (((UIAlertAction?,String?,NSInteger?)->(Void))),destructBlock:@escaping ((UIAlertAction?,String?,NSInteger?)->(Void))){
        if let vc = UIApplication.shared.keyWindow?.rootViewController{
            showAlert(title: title, titleFontSize: titleFontSize, titleColor: titleColor, msg: msg, msgFontSize: msgFontSize, msgColor: msgColor, btnDefautTextArray: btnDefautTextArray, btnCancleTextArray: btnCancleTextArray, btnDestructTextArray: btnDefautTextArray, btnTintColor: btnTintColor, btnDestructTextColor: btnDestructTextColor, alertStyle: alertStyle, in: vc, confirmBlock: confirmBlock, cancleBlock: cancleBlock, destructBlock: destructBlock)
        }
        
    }
    // MARK: - TextField
    static func showAlertWithOneTextField(title: String ,titleFontSize: CGFloat = 16,titleColor: UIColor = UIColor.black, msg: String ,msgFontSize: CGFloat = 15,msgColor: UIColor = UIColor.black,alertStyle: UIAlertController.Style = .alert, in ViewController: UIViewController,onePlaceHolder: String, onePlaceHolderFontSize:CGFloat = 14,onePlaceHodlerColor: UIColor = UIColor.gray,oleftDataType:SQDataType = .sqNone, oleftStrOrImageName:String = "",oleftImage:UIImage = UIImage(),orightDataType:SQDataType = .sqNone, orightStrOrImageName: String, orightImage: UIImage = UIImage(), tfBorderStyle: UITextField.BorderStyle = .roundedRect, tfKeyBoardTyoe:UIKeyboardType = .default,defBtnT:String = NSLocalizedString("确定", comment: "确定"),defBtnColor:UIColor = UIColor.blue,confirmBlock:@escaping ((UIAlertAction?,String?)->(Void)), cancelBtnT:String = NSLocalizedString("取消", comment: "取消"),cancelBtnColor:UIColor = UIColor.gray, cancelBlock:@escaping ((UIAlertAction)->(Void))){
        let alertVC = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alertVC.title = title
        alertVC.titleColor = titleColor
        alertVC.titleFontSize = titleFontSize
        alertVC.message = msg
        alertVC.msgColor = msgColor
        alertVC.msgFontSize = msgFontSize
        
        alertVC.addTextField { (textField) in
            let placeHolderAtt : NSAttributedString = NSAttributedString.init(string: onePlaceHolder, attributes: [NSAttributedString.Key.foregroundColor : onePlaceHodlerColor, NSAttributedString.Key.font : UIFont.systemFont(ofSize: onePlaceHolderFontSize)])
            textField.attributedPlaceholder = placeHolderAtt
            textField.borderStyle = tfBorderStyle
            textField.keyboardType = tfKeyBoardTyoe
            textField.spellCheckingType = UITextSpellCheckingType.no
            textField.autocorrectionType = UITextAutocorrectionType.no
            textField.autocapitalizationType = UITextAutocapitalizationType.none
            if (oleftDataType == .sqImage || oleftDataType == .sqoutImage) {
                let imageView: UIImageView = UIImageView.init(frame: CGRect.init(x: 10, y: 10, width: 20, height: 20))
                imageView.image = oleftImage
                textField.leftView = imageView;
            } else if (oleftDataType == .sqInImageName) {
                let imageView: UIImageView = UIImageView.init(frame: CGRect.init(x: 10, y: 10, width: 20, height: 20))
                imageView.image = UIImage.init(named: oleftStrOrImageName)
                textField.leftView = imageView;
            } else {
                
            }
        }
        let confrimAction: UIAlertAction = UIAlertAction(title: defBtnT, style: .default, handler: { (alertAction) in
            let str = alertVC.textFields?.first!.text;
            confirmBlock(alertAction,str)
        })
        confrimAction.textColor = defBtnColor
        alertVC.addAction(confrimAction)
        
        let cancleAction: UIAlertAction = UIAlertAction(title: cancelBtnT, style: .cancel, handler: { (alertAction) in
            
            cancelBlock(alertAction)
        })
        cancleAction.textColor = cancelBtnColor
        alertVC.addAction(cancleAction)
        
        ViewController.present(alertVC, animated: true) {
            
        }
    }
}

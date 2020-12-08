//
//  UIImage+SQExtension.swift
//  SwiftBaseExample
//
//  Created by administrator on 2019/5/26.
//  Copyright © 2019 administrator. All rights reserved.
//

import UIKit


extension UIImage {
    //返回原型渲染模式的图片
    class func sq_ImageNameWithOriginMode( imageName: String) -> UIImage {
        var image = UIImage(named: imageName)
        image = image?.withRenderingMode(.alwaysOriginal)
        return image!
    }
    //返回原型渲染模式的图片 指定大小
    class func sq_ImageScaleToSize(Image image: UIImage, ScaleToSize size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage!
    }
    //返回原型渲染模式的图片 指定大小
    class func sq_ImageNameWithOriginModeAndScaleSize(ImageName imageName: String, ScaleToSize size: CGSize) -> UIImage {
        var image = UIImage(named: imageName)
        image = image?.withRenderingMode(.alwaysOriginal)
        UIGraphicsBeginImageContext(size)
        image?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    //根据渲染模式返回图片
    class func sq_imageNameWithMode(imageMode: UIImage.RenderingMode, imageName: String) -> UIImage {
        var image = UIImage(named: imageName)
        image = image?.withRenderingMode(imageMode)
        return image!;
    }
    
    class func image(color:UIColor) -> UIImage {
        let rect = CGRect(x:0,y:0,width:1,height:1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

//
//  NSFileManager+SQExtionsion.swift
//  SwiftBaseExample
//
//  Created by 曹亮亮 on 2019/11/27.
//  Copyright © 2019 administrator. All rights reserved.
//

import Foundation

let slibraryPath:String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
//print("library路径----\(libraryPath)")
//
let scachePath:String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
//print("Cache路径----\(cachePath)")
//
let spreferPath:String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.preferencePanesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
//print("Prefer路径----\(preferPath)")
//
let shomeDir:String = NSHomeDirectory()
//print("沙盒地址---\(homeDir)")
//
//let imagePath = Bundle.main.path(forResource: "sale", ofType: "png")!
//print("FlyElephnt-图片路径----\(imagePath)")
//
let sbundlePath = Bundle.main.bundleURL.path
//print("FlyElephnt-App资源文件路径--\(bundlePath)")
//
//let testDataPath = Bundle.main.bundleURL.appendingPathComponent("FlyElephant").path
//print("压缩文件的路径---\(testDataPath)")
// 获取沙盒地址
extension FileManager {
    //Cache路径
    var cachePath: String {
        let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true) as [String]
        return paths[0]
    }
    var libraryPath: String {
        let paths = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true) as [String]
        return paths[0]
    }
    
    var preferPath: String {
        let paths = NSSearchPathForDirectoriesInDomains(.preferencePanesDirectory, .userDomainMask, true) as [String]
        return paths[0]
    }
    
    func pathforCustom(searchpathDir:SearchPathDirectory, searchPathDomainMask:SearchPathDomainMask) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(searchpathDir, searchPathDomainMask, true) as [String]
        return paths[0]
    }
    
}

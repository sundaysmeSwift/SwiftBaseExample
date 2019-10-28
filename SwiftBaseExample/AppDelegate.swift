//
//  AppDelegate.swift
//  SwiftBaseExample
//
//  Created by administrator on 2019/5/26.
//  Copyright © 2019 administrator. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        application.applicationIconBadgeNumber = 0
//        let orientation : UIInterfaceOrientation = .portrait
        UIApplication.shared.statusBarOrientation = .portrait
        window = UIWindow.init()
        window?.frame = UIScreen.main.bounds
//        window?.rootViewController = ViewController(nibName: "ViewController", bundle: nil)
        
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = mainStoryBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }

    
    // 把要打印的日志写在和AppDelegate同一个等级的方法中,即不从属于AppDelegate这个类，这样在真个项目中才能使用这个打印日志,因为这就是程序的入口,
    //这里的T表示不指定message参数类型
    func DLLog<T>(message: T, fileName: String = #file, funcName: String = #function, lineNum : Int = #line) {
        
        #if DEBUG
            /**
             * 此处还要在项目的build settings中搜索swift flags,找到 Other Swift Flags 找到Debug
             * 添加 -D DEBUG,即可。
             */
             // 1.对文件进行处理
            let file = (fileName as NSString).lastPathComponent
            // 2.打印内容
            print("[\(file)][\(funcName)](\(lineNum))\(message)")
            
        #endif
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


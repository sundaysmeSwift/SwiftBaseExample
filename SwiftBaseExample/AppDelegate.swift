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
    //MARK:- 统计mob
//    func addMobClick(){
//        let bundleID:String = Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
//        if bundleID == "com.quantbroker.ios" {
//            let config = UMAnalyticsConfig.sharedInstance()
//            config?.appKey = "5cbe7b8d61f564b049000ae2"
//            config?.ePolicy = REALTIME
//            config?.channelId = "App Store"
//            MobClick.start(withConfigure: config)
//
//            let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
//            MobClick.setAppVersion(version)
//        }
//
//    }
    
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

    //MARK:- 推送
    //极光
    /**在brade桥接文件中
     * 引入 JPush 功能所需头文件
     #import "JPUSHService.h"
     // iOS10 注册 APNs 所需头文件
     #ifdef NSFoundationVersionNumber_iOS_9_x_Max
     #import <UserNotifications/UserNotifications.h>
     #endif
     */
//    func registerJpush(application:UIApplication,launchOptions:[UIApplication.LaunchOptionsKey: Any]?) {
//
//                    if #available(iOS 10.0, *){
//                        let entiity = JPUSHRegisterEntity()
//                        entiity.types = Int(UNAuthorizationOptions.alert.rawValue |
//                            UNAuthorizationOptions.badge.rawValue |
//                            UNAuthorizationOptions.sound.rawValue)
//                        JPUSHService.register(forRemoteNotificationConfig: entiity, delegate: self)
//                    } else if #available(iOS 8.0, *) {
//                        let types = UIUserNotificationType.badge.rawValue |
//                            UIUserNotificationType.sound.rawValue |
//                            UIUserNotificationType.alert.rawValue
//                        JPUSHService.register(forRemoteNotificationTypes: types, categories: nil)
//                    }else {
//                        let type = UIRemoteNotificationType.badge.rawValue |
//                            UIRemoteNotificationType.sound.rawValue |
//                            UIRemoteNotificationType.alert.rawValue
//                        JPUSHService.register(forRemoteNotificationTypes: type, categories: nil)
//                    }
//
//            // 根据环境的不同,设置不同的apsForProduction值,具体看下面参数说明
//                JPUSHService.setup(withOption: launchOptions,
//                                   appKey: "dc94782c1c3e69debb85fde7",
//                                   channel: "app store",
//                                   apsForProduction: true)
//    //            JPUSHService.setup(withOption: launchOptions,
//    //            appKey: "dc94782c1c3e69debb85fde7",
//    //            channel: "",
//    //            apsForProduction: false)
//            //自定义
//
//
//        }
//
//        // 注册deviceToken
//            func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//                JPUSHService.registerDeviceToken(deviceToken)
//                print("Notification token: ", deviceToken)
//            }
//        // 接受数据 //点推送进来执行这个方法
//            func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//                JPUSHService.handleRemoteNotification(userInfo)
//                completionHandler(.newData)
//                print("接受数据 ",userInfo)
//            }
//
//        // 接受数据 //点推送进来执行这个方法
//            func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
//                JPUSHService.handleRemoteNotification(userInfo)
//                print("接受数据",userInfo)
//            }
//
//        // 进入前台的时候,清空角标
//            func applicationWillEnterForeground(_ application: UIApplication) {
//                UIApplication.shared.applicationIconBadgeNumber = 0
//                JPUSHService.setBadge(0)
//    //            UIApplication.shared.cancelAllLocalNotifications()
//            }
}

//MARK:- JPUSHRegisterDelegate
//extension AppDelegate : JPUSHRegisterDelegate{
//    @available(iOS 10.0, *)
//    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, openSettingsFor notification: UNNotification!) {
//        if ((notification != nil) && (notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))!) {
//          //从通知界面直接进入应用
//        }else{
//          //从通知设置界面进入应用
//        }
//    }
//
//    @available(iOS 10.0, *)
//    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
//        print(">JPUSHRegisterDelegate jpushNotificationCenter willPresent");
//        let userInfo = notification.request.content.userInfo
//        if (notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))!{
//            JPUSHService.handleRemoteNotification(userInfo)
//        }
//        completionHandler(Int(UNAuthorizationOptions.alert.rawValue  |
//                           UNAuthorizationOptions.badge.rawValue |
//                           UNAuthorizationOptions.sound.rawValue))// 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
//    }
//    // App在后台时收到推送时的处理
//    @available(iOS 10.0, *)
//    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
//        print(">JPUSHRegisterDelegate jpushNotificationCenter didReceive");
//        let userInfo = response.notification.request.content.userInfo
//        if (response.notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))!{
//            JPUSHService.handleRemoteNotification(userInfo)
//            let alert1: Dictionary = userInfo["aps"]! as! Dictionary<String,Any>
//            let alert2: Dictionary = alert1["alert"] as! Dictionary<String,Any>
//            var badge: Int = (userInfo["aps"] as! Dictionary<String, Any>) ["badge"] as! Int
//            badge -= 1
//            JPUSHService.setBadge(badge)
//            UIApplication.shared.applicationIconBadgeNumber = 0
//            /**
//             *  iOS的应用程序分为3种状态
//             *      1、前台运行的状态UIApplicationStateActive；
//             *      2、后台运行的状态UIApplicationStateInactive；
//             *      3、app关闭状态UIApplicationStateBackground。
//             */
//            // 应用在前台 或者后台开启状态下，不跳转页面，让用户选择。
//            if (UIApplication.shared.applicationState == UIApplication.State.active) || (UIApplication.shared.applicationState == UIApplication.State.background){
////                UIAlertView(title: "推送消息", message: "\(alert2["body"] ?? "")", delegate: nil, cancelButtonTitle: "确定").show()
//            }else{
//                //杀死状态下，直接跳转到跳转页面
//            }
//            // badge清零
//            UIApplication.shared.applicationIconBadgeNumber = 0
//            JPUSHService.resetBadge()
//        }
//        completionHandler()
//    }
//}

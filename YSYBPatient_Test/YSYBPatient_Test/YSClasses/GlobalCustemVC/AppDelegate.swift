//
//  AppDelegate.swift
//  YSYBPatient_Test
//
//  Created by YJ on 17/5/5.
//  Copyright © 2017年 YJ. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()

        let hasLogin = self.hasLogin()
        if hasLogin {

        }
        else {

        }

        self.initSetting()

        return true
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

    // MARK: - 登录逻辑
    func hasLogin() -> Bool {
        let hasLoginKey = UserDefaults.standard.object(forKey: kUserHasLoginKey) as? Bool
        if hasLoginKey == true {
            // 已登录
            let ysTabBarCon = YSTabBarController()
            self.window?.rootViewController = ysTabBarCon

            return true
        }
        else {
            // 未登录
            self.window?.rootViewController = UINavigationController(rootViewController:YSLoginVC())
            return false
        }
    }

    // MARK: - 设置
    func initSetting() -> () {
        if kSystemVersion <= 9.0 {
            UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)
        }

        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = kMainColor
    }
}


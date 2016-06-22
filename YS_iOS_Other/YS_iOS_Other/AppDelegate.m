//
//  AppDelegate.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/6.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // app 启动完成时调用
    
    [self startBaiduMap];
    [self notificationApplyToUser];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    // 即将失去活动状态的时候调用(失去焦点, 不可交互)
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    // app 进入后台时调用
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    // 应用程序即将进入前台的时候调用
    // 一般在该方法中恢复应用程序的数据,以及状态
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    // 重新获取焦点(能够和用户交互)
}

- (void)applicationWillTerminate:(UIApplication *)application {
   
    // 应用程序即将被销毁的时候会调用该方法
    // 注意:如果应用程序处于挂起状态的时候无法调用该方法
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 应用程序接收到内存警告的时候就会调用
    // 一般在该方法中释放掉不需要的内存
}

#pragma mark - 百度地图
- (void)startBaiduMap
{
    // 启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc] init];
    // 如果要关注网络及授权验证事件，请设置 generalDelegate
    BOOL ret = [_mapManager start:kBaiduMapAK generalDelegate:nil];
    if (!ret) {
        NSLog(@"Baidu Map Manager start failed!");
    }
}

#pragma mark - 程序启动时，向用户获取发通知的权限
- (void)notificationApplyToUser
{
    if (kSystemVersion >= 8.0) {
        UIUserNotificationType type = UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
        UIUserNotificationSettings *setting=[UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    }
}


@end

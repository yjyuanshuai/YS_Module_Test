//
//  AppDelegate.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/6.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "AppDelegate.h"
#import "YSTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // app 启动完成时调用
    
    [self initLogs];
    [self initSetting];
    [self login];
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

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    // 自定义了 URL scheme，另一个应用通过 url 向本应用传递参数 或 发起调用
    
//    if ([sourceApplication isEqualToString:@"com.3Sixty.CallCustomURL"])
//    {
        // 限定只有某一个应用可以传参
        
        NSLog(@"Calling Application Bundle ID: %@", sourceApplication);
        NSLog(@"URL scheme:%@", [url scheme]);
        NSLog(@"URL query: %@", [url query]);
        
        return YES;
//    }
//    else 
//        return NO;
    
    /*
     
     有一点要特别注意，你不能阻止其他应用通过自定义 URL scheme 调用你的应用，然而你可以跳过后续的操作并返回 NO，就像上面的代码那样。也就是说，如果你想阻止其它应用调用你的应用，创建一个与众不同的 URL scheme。尽管这不能保证你的应用不会被调用，但至少大大降低了这种可能性
     
     */
}

#pragma mark - 初始设置
- (void)initSetting
{
    self.window.frame = [[UIScreen mainScreen] bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // 导航栏
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setBarTintColor:YSColorDefault];

    // TabBar
    [UITabBar appearance].tintColor = [UIColor whiteColor];
    [UITabBar appearance].barTintColor = YSColorDefault;
    
    // TabBarItem
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
}

#pragma mark - CocoaLumberjack
- (void)initLogs
{
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
}

#pragma mark - 登录逻辑
- (void)login
{
    YSTabBarController * ysTabBarCon = [YSTabBarController sharedYSTabBarController];
    ysTabBarCon.selectedIndex = 0;
    self.window.rootViewController = ysTabBarCon;
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

//
//  YSActivityIndicatorManager.m
//  加载动画Test
//
//  Created by YJ on 16/4/29.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSActivityIndicatorManager.h"
#import "YSActivityIndicator.h"

@implementation YSActivityIndicatorManager

+ (void)addDefaultIndicatorInController:(UIViewController *)viewController titleStr:(NSString *)title
{
    YSActivityIndicator * loadingView = [YSActivityIndicator showInViewController:viewController];
    loadingView.ysType = YSLoadViewTypeSystemActIndicatorDefault;
    loadingView.ysActivityIndicatorStyle = UIActivityIndicatorViewStyleWhite;
    loadingView.titleStr = title;
    loadingView.titleTextColor = [UIColor whiteColor];
}

+ (void)addDetailIndicatorInController:(UIViewController *)viewController titleStr:(NSString *)title desc:(NSString *)desc
{
    YSActivityIndicator * loadingView = [YSActivityIndicator showInViewController:viewController];
    loadingView.ysType = YSLoadViewTypeSystemActIndicatorDetail;
    loadingView.ysActivityIndicatorStyle = UIActivityIndicatorViewStyleGray;
    loadingView.titleStr = title;
    loadingView.descStr = desc;
    loadingView.titleTextColor = [UIColor blackColor];
    loadingView.descTextColor = [UIColor blackColor];
}

+ (void)hideInController:(UIViewController *)viewController
{
    [YSActivityIndicator hideInViewController:viewController];
}

@end

//
//  YSActivityIndicator.h
//  加载动画Test
//
//  Created by YJ on 16/4/28.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YSLoadViewType)
{
    YSLoadViewTypeSystemActIndicatorDefault,     // 系统菊花 + 标题
    YSLoadViewTypeSystemActIndicatorDetail,      // 系统菊花 + 标题 + 描述
    YSLoadViewTypeTextDefault,                   // 标题
    YSLoadViewTypeTextDetail,                    // 标题 + 描述
    YSLoadViewTypeCustom                         // 自定义
};

@interface YSActivityIndicator : UIView

#pragma mark - property -

@property (nonatomic, assign) YSLoadViewType ysType;

@property (nonatomic, strong) UIActivityIndicatorView * ysAcitityIndicator;
@property (nonatomic, assign) UIActivityIndicatorViewStyle ysActivityIndicatorStyle;
@property (nonatomic, strong) NSString * titleStr;
@property (nonatomic, strong) NSString * descStr;
@property (nonatomic, strong) UIFont * titleFont;
@property (nonatomic, strong) UIFont * descFont;
@property (nonatomic, strong) UIColor * titleTextColor;
@property (nonatomic, strong) UIColor * descTextColor;

@property (nonatomic, strong) UIView * ysCustomView;

@property (nonatomic, assign) NSTimeInterval overTimeInterval;
@property (nonatomic, strong) UIViewController * blongToViewController;

#pragma mark - instance method -


#pragma mark - class method -
+ (instancetype)showInViewController:(UIViewController *)viewController;
+ (void)hideInViewController:(UIViewController *)viewController;

@end

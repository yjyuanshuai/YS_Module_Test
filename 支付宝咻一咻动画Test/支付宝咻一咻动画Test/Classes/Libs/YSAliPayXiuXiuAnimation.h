//
//  YSAliPayXiuXiuAnimation.h
//  支付宝咻一咻动画Test
//
//  Created by YJ on 16/1/30.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YSAliPayXiuXiuAnimation : NSObject

@property (nonatomic, assign) float ysRadius;     //动画的半径
@property (nonatomic, strong) UIColor * ysColor;  //颜色

#pragma mark - instance method
- (void)showYSAliPayAnimationInViewController:(UIViewController *)viewController repeat:(BOOL)repeat;
- (void)dismissYSAliPayXiuXiu;

#pragma mark - class method
+ (void)ysAliPayXiuXiuInViewController:(UIViewController *)viewController repeat:(BOOL)repeat radius:(float)ysRadius color:(UIColor *)ysColor;
+ (void)ysAliPayXiuXiuDismiss;

@end

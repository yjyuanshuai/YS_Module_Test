//
//  YSBarCodeImageView.h
//  二维码生成与扫描Test
//
//  Created by YJ on 16/1/20.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSBarCodeImageView : UIImageView

/**
 *
 *
 */
- (instancetype)initWithFrame:(CGRect)frame
                       string:(NSString *)aString;

/**
 *
 */
+ (instancetype)bcImageViewWithFrame:(CGRect)frame
                              string:(NSString *)string;

/**
 *
 */
+ (instancetype)bcImageViewWithFrame:(CGRect)frame
                              string:(NSString *)string
                      viewController:(UIViewController *)viewController;

@end

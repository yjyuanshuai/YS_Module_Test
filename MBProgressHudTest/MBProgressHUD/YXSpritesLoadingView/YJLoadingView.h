//
//  YJLoadingView.h
//  MBProgressHudTest
//
//  Created by YJ on 15/12/25.
//  Copyright © 2015年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YJLoadingViewType)
{
    YJLoadingViewTypeText,
    YJLoadingViewTypeImage,
    YJLoadingViewTypeTextAndImage
};


@interface YJLoadingView : UIView

@property (nonatomic, assign) CGFloat alphaValue;       // 默认1
@property (nonatomic, assign) CGSize loadViewSize;      // 默认是 150*150
@property (nonatomic, assign) float timeOverInterval;   // 超时时间，默认30秒
@property (nonatomic, assign) YJLoadingViewType loadViewType;   // 默认 YJLoadingViewTypeImage
@property (nonatomic, copy) NSString * message;         // 提示语，默认空



//2
- (instancetype)initWithFrame:(CGRect)frame;
- (void)showLoadingView;
- (void)dismissLoadingView;


//3
+ (void)showImageLoadingViewToView:(UIViewController *)viewController;
+ (void)showTextLoadingViewToView:(UIViewController *)viewController text:(NSString *)text;
+ (void)showImageAndTextLoadingView:(UIViewController *)viewController text:(NSString *)text;


@end

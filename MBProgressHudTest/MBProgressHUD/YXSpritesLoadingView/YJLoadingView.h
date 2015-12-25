//
//  YJLoadingView.h
//  MBProgressHudTest
//
//  Created by YJ on 15/12/25.
//  Copyright © 2015年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJLoadingView : UIView

@property (nonatomic, strong) NSArray * imageArray;     // 帧动画图片
@property (nonatomic, copy) NSString * loadingText;     // 提示语
@property (nonatomic, assign) NSUInteger animationDurtionTime;  // 动画时间
@property (nonatomic, assign) CGSize viewSize;          // 尺寸
@property (nonatomic, assign) CGFloat alphaValue;               // 透明度

- (instancetype)init;
//- (instancetype)initWithFrame:(CGRect)frame;

+ (void)showWithImages:(NSArray *)imageArr andText:(NSString *)loadingText;

@end

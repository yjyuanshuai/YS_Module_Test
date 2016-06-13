//
//  YSBarCodeImageView.m
//  二维码生成与扫描Test
//
//  Created by YJ on 16/1/20.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSBarCodeImageView.h"
#import "Code39.h"

@implementation YSBarCodeImageView

#pragma mark - instance method
- (instancetype)initWithFrame:(CGRect)frame string:(NSString *)aString
{
    if (self = [super initWithFrame:frame]) {
        self.image = [self returnBarCodeImageWithString:aString];
    }
    return self;
}

#pragma mark - class method
+ (instancetype)bcImageViewWithFrame:(CGRect)frame string:(NSString *)string
{
    YSBarCodeImageView * bcImageView = [[YSBarCodeImageView alloc] initWithFrame:frame string:string];
    return bcImageView;
}

+ (instancetype)bcImageViewWithFrame:(CGRect)frame string:(NSString *)string viewController:(UIViewController *)viewController
{
    YSBarCodeImageView * bcImageView = [YSBarCodeImageView bcImageViewWithFrame:frame string:string];
    [viewController.view addSubview:bcImageView];
    return bcImageView;
}

#pragma mark - tool
/**
 *  生成条形码的图片
 */
- (UIImage *)returnBarCodeImageWithString:(NSString *)aString
{
    return [Code39 code39ImageFromString:aString Width:self.frame.size.width Height:self.frame.size.height];
}


@end

//
//  UIImage+ToolForImage.m
//  自定义emoji键盘
//
//  Created by YJ on 16/2/1.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "UIImage+ToolForImage.h"

@implementation UIImage (ToolForImage)

/**
 *  根据颜色，获取纯色的图片
 */
+ (instancetype)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  根据图片名，获取去除蒙版的原始图片
 */
+ (instancetype)originImageWithImageString:(NSString *)imageStr type:(NSString *)imageType
{
    NSString * path = [[NSBundle mainBundle] pathForResource:imageStr ofType:imageType];
    UIImage * image = [UIImage imageWithContentsOfFile:path];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


@end

//
//  UIImage+YSImageCategare.m
//  YS_iOS_Other
//
//  Created by YJ on 16/8/12.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "UIImage+YSImageCategare.h"

@implementation UIImage (YSImageCategare)

/**
 *  颜色转图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color
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

@end

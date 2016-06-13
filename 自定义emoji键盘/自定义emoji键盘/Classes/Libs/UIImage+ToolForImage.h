//
//  UIImage+ToolForImage.h
//  自定义emoji键盘
//
//  Created by YJ on 16/2/1.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ToolForImage)

/**
 *  根据颜色，获取纯色的图片
 */
+ (instancetype)imageWithColor:(UIColor *)color;

/**
 *  根据图片名，获取去除蒙版的原始图片
 */
+ (instancetype)originImageWithImageString:(NSString *)imageStr type:(NSString *)imageType;


@end

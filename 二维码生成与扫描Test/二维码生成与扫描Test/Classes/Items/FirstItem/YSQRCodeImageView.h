//
//  YSQRCodeImageView.h
//  二维码生成与扫描Test
//
//  Created by YJ on 16/1/20.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSQRCodeImageView : UIImageView
/**
 *  实例方法
 *  将string生成二维码
 */

- (instancetype)initWithFrame:(CGRect)frame
                       String:(NSString *)aString;

/**
 *  类方法
 *  需手动添加到对应的 view 上
 */
+ (instancetype)qrImageViewWithFrame:(CGRect)frame
                              String:(NSString *)aString;


/**
 *  自动添加到 viewController.view 上
 *
 */
+ (instancetype)qrImageViewWithFrame:(CGRect)frame
                              String:(NSString *)aString
                      viewController:(UIViewController *)viewController;

@end

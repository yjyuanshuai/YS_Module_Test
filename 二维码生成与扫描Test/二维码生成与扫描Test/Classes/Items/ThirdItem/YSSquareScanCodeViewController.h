//
//  YSSquareScanCodeViewController.h
//  二维码生成与扫描Test
//
//  Created by YJ on 16/1/20.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^YSSquareScanBlock) (NSString * codeStr);

@interface YSSquareScanCodeViewController : UIViewController

- (instancetype)initWithBlock:(YSSquareScanBlock)block;

@end

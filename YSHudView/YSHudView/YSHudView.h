//
//  YSHudView.h
//  HudDemo
//
//  Created by YJ on 16/5/31.
//  Copyright © 2016年 Matej Bukovinski. All rights reserved.
//

#define _DEVICE_WIDTH   [[UIScreen mainScreen] bounds].size.width
#define _DEVICE_HEIGHT  [[UIScreen mainScreen] bounds].size.height
#define _DEVICE_HEIGHT_NO_20    [[UIScreen mainScreen] bounds].size.height - 20
#define _DEVICE_HEIGHT_NO_64    [[UIScreen mainScreen] bounds].size.height - 64

#define _APP_KEYWINDOW  [UIApplication sharedApplication].keyWindow



#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface YSHudView : NSObject

@property (nonatomic, assign) BOOL isUserEnable;
@property (nonatomic, strong, readonly) MBProgressHUD * mbProgressHud;
@property (nonatomic, strong) UIView * hudView;

+ (instancetype)sharedYSHudView;


- (void)showYiBaoHUD;
- (void)hideHUD;
- (void)stopOrDisplayMBHudWithmsg:(NSString*)msg finsh:(void (^)(void))finshBlock;


@end

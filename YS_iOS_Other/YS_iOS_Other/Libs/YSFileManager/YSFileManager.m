//
//  YSFileManager.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/30.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSFileManager.h"

@implementation YSFileManager

#pragma mark - 文件管理

+ (BOOL)fileHasExist:(NSString *)path
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        return YES;
    }
    NSLog(@"---------------- file 不存在 ！");
    return NO;
}

@end

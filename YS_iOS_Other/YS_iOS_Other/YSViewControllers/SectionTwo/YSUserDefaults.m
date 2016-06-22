//
//  YSUserDefaults.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/22.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSUserDefaults.h"

@implementation YSUserDefaults

+ (instancetype)shareUserDefualts
{
    static YSUserDefaults * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[YSUserDefaults alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        _userName = @"";
        _passWord = @"";
        _isRememberPassWord = NO;
    }
    return self;
}

- (void)saveUserDefaults
{
    // 1、获取 default
    NSUserDefaults * tempDefault = [NSUserDefaults standardUserDefaults];
    
    // 2、存储数据
    [tempDefault setBool:_isRememberPassWord forKey:UserRememberPassWord];
    [tempDefault setObject:_userName forKey:UserName];
    [tempDefault setObject:_passWord forKey:UserPassWord];
    
    // 3、强制立即存储
    [tempDefault synchronize];
}

- (void)readUserDefaults
{
    NSUserDefaults * tempDefault = [NSUserDefaults standardUserDefaults];
    
    _isRememberPassWord = [tempDefault boolForKey:UserRememberPassWord];
    _userName = [tempDefault objectForKey:UserName];
    _passWord = [tempDefault objectForKey:UserPassWord];
    
    NSLog(@"------------- %@ ----------- %@ ---------- %d", _userName, _passWord, _isRememberPassWord);
}

@end

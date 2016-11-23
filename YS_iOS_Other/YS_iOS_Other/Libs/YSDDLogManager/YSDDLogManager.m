//
//  YSDDLogManager.m
//  YS_iOS_Other
//
//  Created by YJ on 16/11/23.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSDDLogManager.h"
#import "YSDevSettingFile.h"

int ddLogLevel = DDLogLevelVerbose;

@implementation YSDDLogManager

+ (instancetype)shareDDLogManager
{
    __block YSDDLogManager * instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[YSDDLogManager alloc] init];
    });
    return instance;
}


- (instancetype)init
{
    if (self = [super init]) {
        
        DDLogInfo(@"------------ current ddLogLevel: %d", ddLogLevel);
        
#ifdef Project_Env

#if Project_Env == 0x01
        int ddLogLevel = DDLogLevelVerbose;
#else
        int ddLogLevel = DDLogLevelWarning;
#endif
#elif
        int ddLogLevel = DDLogLevelOff;
#endif
        
        
        
#ifdef  YSDDTTYLog_ON
        
        // DDTTYLoyger（发送日志语句到Xcode控制台，如果可用）
        [DDLog addLogger:[DDTTYLogger sharedInstance]];
#endif
        
        
        
        
#ifdef  YSDDASLLog_ON
        
        // DDASLLogger（发送日志语句到苹果的日志系统，以便它们显示在Console.app上）
        [DDLog addLogger:[DDASLLogger sharedInstance]];
#endif
        
        
        
        
#ifdef YSDDFileLog_ON
        
        // DDFIleLoger（把日志语句发送至文件）
        DDFileLogger * fileLogger = [[DDFileLogger alloc] init];
        // 保存周期
        fileLogger.rollingFrequency = 660 * 660 * 24;
        // 最大的日志文件数量
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
        
        [DDLog addLogger:fileLogger];
        
#endif

    }
    
    return self;
}

@end

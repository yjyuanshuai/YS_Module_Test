//
//  DeviceInfoTool.h
//  SomeToolsTest
//
//  Created by YJ on 16/4/20.
//  Copyright © 2016年 YJ. All rights reserved.
//

/**
 *  
 */

#import <Foundation/Foundation.h>

@interface DeviceInfoTool : NSObject

/************      ***********/
#pragma mark - class method -
#pragma mark - UIDevice
+ (NSString *)deviceName;           // 设备名
+ (NSString *)deviceSystemVersion;  // 系统版本

#pragma mark - NSBundle
+ (NSString *)AppName;              // App 应用名
+ (NSString *)AppVersion;           // App 应用版本
+ (NSString *)AppBuildVersion;      // App 应用 build 版本

#pragma mark - NSLocale
+ (NSString *)countryNumber;    //国家
+ (NSString *)languageName;     //语言

@end

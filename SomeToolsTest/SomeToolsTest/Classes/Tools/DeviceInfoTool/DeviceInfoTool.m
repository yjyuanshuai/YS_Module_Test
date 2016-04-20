//
//  DeviceInfoTool.m
//  SomeToolsTest
//
//  Created by YJ on 16/4/20.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "DeviceInfoTool.h"
#import <UIKit/UIKit.h>

@implementation DeviceInfoTool

#pragma mark - class method -
#pragma mark - UIDevice
+ (NSString *)deviceName
{
    return [[UIDevice currentDevice] name];
}

+ (NSString *)deviceSystemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)deviceSystemModel
{
    return [[UIDevice currentDevice] model];
}

+ (NSString *)deviceLocalModel
{
    return [[UIDevice currentDevice] localizedModel];
}

#pragma mark - NSBundle
+ (NSString *)AppName
{
    NSDictionary * dicInfo = [[NSBundle mainBundle] infoDictionary];
    return [dicInfo objectForKey:@"CFBundleDisplayName"];
}

+ (NSString *)AppVersion
{
    NSDictionary * dicInfo = [[NSBundle mainBundle] infoDictionary];
    return [dicInfo objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)AppBuildVersion
{
    NSDictionary * dicInfo = [[NSBundle mainBundle] infoDictionary];
    return [dicInfo objectForKey:@"CFBundleVersion"];
}

#pragma mark - NSLocale
+ (NSString *)countryNumber
{
    NSLocale * locale = [NSLocale currentLocale];
    return [locale localeIdentifier];
}

+ (NSString *)languageName
{
    NSArray * languageArr = [NSLocale preferredLanguages];
    return [languageArr objectAtIndex:0];
}


@end

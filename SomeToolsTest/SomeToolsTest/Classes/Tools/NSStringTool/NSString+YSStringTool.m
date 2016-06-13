//
//  NSString+YSStringTool.m
//  SomeToolsTest
//
//  Created by YJ on 16/4/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "NSString+YSStringTool.h"

@implementation NSString (YSStringTool)

#pragma mark - 判空/NULL/nil -
- (BOOL)isBlankString
{
    if ([self isEqualToString:@""] || self == nil || [self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    return NO;
}

#pragma mark - 去空格 -
- (NSString *)removeSpaceString
{
    NSArray * arr = [self componentsSeparatedByString:@" "];
    NSString * resStr;
    for (NSString * str in arr) {
        if (![str isBlankString]) {
            [resStr stringByAppendingString:str];
        }
    }
    return resStr;
}


@end

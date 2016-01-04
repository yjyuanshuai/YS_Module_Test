//
//  NSString+Utility.m
//  EncryptionTest
//
//  Created by YJ on 16/1/4.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "NSString+Utility.h"


@implementation NSString (Utility)

// 判空
+ (BOOL)isBlankString:(NSString *)str
{
    if ([str isEqualToString:@""] || [str isEqual:nil] || [str isKindOfClass:[NSNull  class]]) {
        return YES;
    }
    return NO;
}


@end

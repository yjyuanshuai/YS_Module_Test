//
//  NSString+YSStringTool.h
//  SomeToolsTest
//
//  Created by YJ on 16/4/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YSStringTool)

#pragma mark - 判空/NULL/nil -
- (BOOL)isBlankString;

#pragma mark - 去空格 -
- (NSString *)removeSpaceString;


@end

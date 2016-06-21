//
//  NSString+BreakLine.h
//  YS_iOS_Other
//
//  Created by YJ on 16/6/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BreakLine)

/**
 *  将 “\n”解析为转行
 */
- (instancetype)analyseBreakLine;

/**
 *  判空
 */
- (BOOL)isBlank;

/**
 *  去除空格
 */
- (instancetype)removeSpace;

/**
 *  去除空格 + 无效值（如：null，nil等）
 */
- (instancetype)removeSpaceAndInvalid;

/**
 *  返回高度
 */
- (CGFloat)calculateHeightWithMaxWidth:(CGFloat)maxWidth font:(UIFont *)font miniHeight:(CGFloat)miniHeight;

@end

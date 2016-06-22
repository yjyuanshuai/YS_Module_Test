//
//  NSString+BreakLine.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "NSString+BreakLine.h"

@implementation NSString (BreakLine)

- (instancetype)analyseBreakLine
{
    NSString * retStr = self;
    return [retStr stringByReplacingOccurrencesOfString:@"\\n" withString:retStr];
}

/**
 *  判空
 */
- (BOOL)isBlank
{
    if ([self isEqualToString:@""] ||
        [self isEqual:[NSNull class]] ||
        self == nil ) {
        
        return YES;
    }
    
    return NO;
}

/**
 *  去除空格
 */
- (instancetype)removeSpace
{
    return self;
}

/**
 *  去除空格 + 无效值（如：null，nil等）
 */
- (instancetype)removeSpaceAndInvalid
{
    return self;
}

- (CGFloat)calculateHeightWithMaxWidth:(CGFloat)maxWidth font:(UIFont *)font miniHeight:(CGFloat)miniHeight
{
    UIFont * curFont = font;
    if (font == nil) {
        curFont = [UIFont systemFontOfSize:16.0];
    }
    CGSize rect = [self boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:@{NSFontAttributeName:curFont}
                                     context:nil].size;
    if (rect.height < miniHeight) {
        return miniHeight;
    }
    return rect.height;
}


@end

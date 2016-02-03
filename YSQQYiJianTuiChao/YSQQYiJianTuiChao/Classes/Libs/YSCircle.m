//
//  YSCircle.m
//  YSQQYiJianTuiChao
//
//  Created by YJ on 16/2/3.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSCircle.h"

@implementation YSCircle

#pragma mark - instance method
- (instancetype)initWithCenterPoint:(CGPoint)center radius:(CGFloat)radius
{
    if (self = [super init]) {
        self.ysCenter = center;
        self.ysRadius = radius;
    }
    return self;
}

#pragma mark - class method
+ (instancetype)circleWithCenterPoint:(CGPoint)center radius:(CGFloat)radius
{
    YSCircle * ysCircle = [[YSCircle alloc] initWithCenterPoint:center radius:radius];
    return ysCircle;
}
@end

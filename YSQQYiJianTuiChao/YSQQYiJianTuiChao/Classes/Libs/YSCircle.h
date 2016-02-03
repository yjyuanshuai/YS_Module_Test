//
//  YSCircle.h
//  YSQQYiJianTuiChao
//
//  Created by YJ on 16/2/3.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSCircle : UIView

@property (nonatomic, assign) CGPoint ysCenter;   //圆心坐标
@property (nonatomic, assign) CGFloat ysRadius;     //半径

#pragma mark - instance method
- (instancetype)initWithCenterPoint:(CGPoint)center radius:(CGFloat)radius;

#pragma mark - class method
+ (instancetype)circleWithCenterPoint:(CGPoint)center radius:(CGFloat)radius;

@end

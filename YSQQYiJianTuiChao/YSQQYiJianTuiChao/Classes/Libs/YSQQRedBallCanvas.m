//
//  YSQQRedBallCanvas.m
//  YSQQYiJianTuiChao
//
//  Created by YJ on 16/2/3.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSQQRedBallCanvas.h"

#define RADIUS 40.0

@implementation YSQQRedBallCanvas
{
    UIBezierPath * _bezierPath; //贝塞尔曲线
    CGPoint _touchPoint;      //拖拽的点
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initData];
    }
    return self;
}

- (void)initData
{
    self.centerCircle = [YSCircle circleWithCenterPoint:self.center radius:RADIUS];
    self.touchCircle = [YSCircle circleWithCenterPoint:self.center radius:RADIUS];
    
    _touchPoint = self.center;
    
    NSLog(@"--------- x: %f,    +++++++++++ y: %f", self.center.x, self.center.y);
}

- (void)drawRect:(CGRect)rect
{
    _bezierPath = [[UIBezierPath alloc] init];
    
    [self drawCenterCircle];
    [self drawTouchCircle:_touchPoint];
//    [self drawBezierCurveWithCircle1:self.centerCircle Circle2:self.touchCircle];
}

#pragma mark - 监听手势 -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    _touchPoint = [touch locationInView:self];
    
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    _touchPoint = [touch locationInView:self];
    
    [self setNeedsDisplay];
}

#pragma mark - draw circle（画圆） -

- (void) drawCenterCircle {
    [self drawCircle:_bezierPath circle:_centerCircle];
}

- (void) drawTouchCircle:(CGPoint)center {
    _touchCircle.ysCenter = center;
    
    [self drawCircle:_bezierPath circle:_touchCircle];
}

- (void)drawCircle:(UIBezierPath *)path circle:(YSCircle *)circle {
    [_bezierPath addArcWithCenter:circle.ysCenter radius:circle.ysRadius startAngle:0 endAngle:360 clockwise:true];
    
    [_bezierPath fill];
    [_bezierPath stroke];
    
    [_bezierPath removeAllPoints];
}

#pragma mark - draw curve（画贝塞尔曲线） -

- (void)drawBezierCurveWithCircle1:(YSCircle *)circle1 Circle2:(YSCircle *)circle2 {
    float circle1_x = circle1.ysCenter.x;
    float circle1_y = circle1.ysCenter.y;
    float circle2_x = circle2.ysCenter.x;
    float circle2_y = circle2.ysCenter.y;
    
    //连心线的长度
    float d = sqrt(powf(circle1_x - circle2_x, 2) + powf(circle1_y - circle2_y, 2));
    
    //连心线x轴的夹角
    float angle1 = atan((circle2_y - circle1_y) / (circle1_x - circle2_x));
    //连心线和公切线的夹角
    float angle2 = asin((circle1.ysRadius - circle2.ysRadius) / d);
    //切点到圆心和x轴的夹角
    float angle3 = M_PI_2 - angle1 - angle2;
    float angle4 = M_PI_2 - angle1 + angle2;
    
    float offset1_X = cos(angle3) * circle1.ysRadius;
    float offset1_Y = sin(angle3) * circle1.ysRadius;
    float offset2_X = cos(angle3) * circle2.ysRadius;
    float offset2_Y = sin(angle3) * circle2.ysRadius;
    float offset3_X = cos(angle4) * circle1.ysRadius;
    float offset3_Y = sin(angle4) * circle1.ysRadius;
    float offset4_X = cos(angle4) * circle2.ysRadius;
    float offset4_Y = sin(angle4) * circle2.ysRadius;
    
    float p1_x = circle1_x - offset1_X;
    float p1_y = circle1_y - offset1_Y;
    float p2_x = circle2_x - offset2_X;
    float p2_y = circle2_y - offset2_Y;
    float p3_x = circle1_x + offset3_X;
    float p3_y = circle1_y + offset3_Y;
    float p4_x = circle2_x + offset4_X;
    float p4_y = circle2_y + offset4_Y;
    
    CGPoint p1 = CGPointMake(p1_x, p1_y);
    CGPoint p2 = CGPointMake(p2_x, p2_y);
    CGPoint p3 = CGPointMake(p3_x, p3_y);
    CGPoint p4 = CGPointMake(p4_x, p4_y);
    
    
    CGPoint p1_center_p4 = CGPointMake((p1_x + p4_x) / 2, (p1_y + p4_y) / 2);
    CGPoint p2_center_p3 = CGPointMake((p2_x + p3_x) / 2, (p2_y + p3_y) / 2);
    
    [self drawBezierCurveStartAt:p1 EndAt:p2 controlPoint:p2_center_p3];
    [self drawLineStartAt:p2 EndAt:p4];
    [self drawBezierCurveStartAt:p4 EndAt:p3 controlPoint:p1_center_p4];
    [self drawLineStartAt:p3 EndAt:p1];
    
    [_bezierPath moveToPoint:p1];
    [_bezierPath closePath];
    
    [_bezierPath stroke];
}


- (void)drawBezierCurveStartAt:(CGPoint)startPoint EndAt:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint
{
    
}

- (void)drawLineStartAt:(CGPoint)startPoint EndAt:(CGPoint)endPoint
{

}

#pragma mark - 更改半径 -
-(void)changeCenterCircleRadiusTo:(float)radius {
    _centerCircle.ysRadius = radius;
    [self setNeedsDisplay];
}

-(void)changeTouchCircleRadiusTo:(float)radius {
    _touchCircle.ysRadius = radius;
    [self setNeedsDisplay];
}

@end

//
//  ViewController.m
//  BeziarPathAndCAShapeLayerTest
//
//  Created by YJ on 16/2/29.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self createRectangle];
//    [self createRoundRectangle];
//    [self createCircle];
    [self beziarLine];
//    [self animationLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 直角矩形
- (void)createRectangle
{
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:CGRectMake(110, 70, 100, 100)];
    CAShapeLayer * layer = [CAShapeLayer layer];
    
    layer.path = path.CGPath;
    layer.fillColor = [UIColor redColor].CGColor;   //填充色
    layer.strokeColor = [UIColor blackColor].CGColor;   //边框色
    [self.view.layer addSublayer:layer];
}

#pragma mark - 圆角矩形
- (void)createRoundRectangle
{
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(110, 70 + 100 + 10, 100, 100) cornerRadius:50];
    CAShapeLayer * layer = [CAShapeLayer layer];
    
    layer.path = path.CGPath;
    layer.fillColor = [UIColor blackColor].CGColor;
    layer.strokeColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer];
}

#pragma mark - 画圆
- (void)createCircle
{
    CGFloat radius =50.0;
    CGFloat startAngle = 0.0;
    CGFloat endAngle = M_PI/2;
    
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(110 + radius, 70 + 100 + 10 + 100 + radius + 10) radius:radius startAngle:startAngle endAngle:endAngle clockwise:NO];
    // 注意 clockwise
    CAShapeLayer * layer = [CAShapeLayer layer];
    
    layer.path = path.CGPath;
    layer.fillColor = [UIColor redColor].CGColor;
    layer.strokeColor = [UIColor blackColor].CGColor;
    [self.view.layer addSublayer:layer];
}

#pragma mark - 贝塞尔曲线的组成
- (void)beziarLine
{
    CGPoint startPoint = CGPointMake(50, 120); //起始点
    CGPoint endPoint = CGPointMake(250, 120);   //终点
    CGPoint controlPoint = CGPointMake(150, 60);//控制点1
    CGPoint controlPoint2 = CGPointMake(200, 180);   //控制点2
    
    //起点
    CALayer * layer1 = [CALayer layer];
    layer1.frame = CGRectMake(startPoint.x, startPoint.y, 5, 5);
    layer1.backgroundColor = [UIColor redColor].CGColor;

    //终点
    CALayer * layer2 = [CALayer layer];
    layer2.frame = CGRectMake(endPoint.x, endPoint.y, 5, 5);
    layer2.backgroundColor = [UIColor blackColor].CGColor;
    
    //控制点1
    CALayer * layer3 = [CALayer layer];
    layer3.frame = CGRectMake(controlPoint.x, controlPoint.y, 5, 5);
    layer3.backgroundColor = [UIColor blueColor].CGColor;
    
    //控制点2
    CALayer * layer4 = [CALayer layer];
    layer4.frame = CGRectMake(controlPoint2.x, controlPoint2.y, 5, 5);
    layer4.backgroundColor = [UIColor redColor].CGColor;
    
    //曲线
    UIBezierPath * path = [UIBezierPath bezierPath];
    CAShapeLayer * layer = [CAShapeLayer layer];
    
    [path moveToPoint:startPoint];
//    [path addQuadCurveToPoint:endPoint controlPoint:controlPoint];
    [path addCurveToPoint:endPoint controlPoint1:controlPoint controlPoint2:controlPoint2];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor lightGrayColor].CGColor;
    layer.strokeColor = [UIColor blackColor].CGColor;
    
    [self.view.layer addSublayer:layer1];
    [self.view.layer addSublayer:layer2];
    [self.view.layer addSublayer:layer3];
    [self.view.layer addSublayer:layer4];
    [self.view.layer addSublayer:layer];
}

#pragma mark - 动画1
- (void)animationLayer
{
    CGPoint startPoint = CGPointMake(50, 120); //起始点
    CGPoint endPoint = CGPointMake(250, 120);   //终点
    CGPoint controlPoint = CGPointMake(150, 60);//控制点1
    CGPoint controlPoint2 = CGPointMake(200, 180);   //控制点2

    //曲线
    UIBezierPath * path = [UIBezierPath bezierPath];
    CAShapeLayer * layer = [CAShapeLayer layer];
    
    [path moveToPoint:startPoint];
    [path addCurveToPoint:endPoint controlPoint1:controlPoint controlPoint2:controlPoint2];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor lightGrayColor].CGColor;
    layer.strokeColor = [UIColor blackColor].CGColor;
    
    [self.view.layer addSublayer:layer];
    
//    [self animationOne:layer];
    [self animationTwo:layer];
//    [self animationThree:layer];
}

#pragma mark - 动画1
- (void)animationOne:(CAShapeLayer *)layer
{
    //动画1
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 2;
    [layer addAnimation:animation forKey:@""];
}

#pragma mark - 动画2
- (void)animationTwo:(CAShapeLayer *)layer
{
    //动画2
    layer.strokeStart = 0.5;
    layer.strokeEnd = 0.5;
    
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    animation.fromValue = @0.5;
    animation.toValue = @0;
    animation.duration = 2;
    
    CABasicAnimation * animation2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation2.fromValue = @0.5;
    animation2.toValue = @1;
    animation2.duration = 2;
    
    [layer addAnimation:animation forKey:@""];
    [layer addAnimation:animation2 forKey:@""];

}


#pragma mark - 动画3
- (void)animationThree:(CAShapeLayer *)layer
{
    //动画3
    CABasicAnimation * animation2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation2.fromValue = @0;
    animation2.toValue = @1;
    animation2.duration = 2;
    
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
    animation.fromValue = @1;
    animation.toValue = @10;
    animation.duration = 2;
    
    [layer addAnimation:animation forKey:@""];
    [layer addAnimation:animation2 forKey:@""];
}


@end









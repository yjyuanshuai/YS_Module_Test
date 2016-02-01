//
//  YSAliPayXiuXiuAnimation.m
//  支付宝咻一咻动画Test
//
//  Created by YJ on 16/1/30.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSAliPayXiuXiuAnimation.h"

@implementation YSAliPayXiuXiuAnimation
{
    CALayer *_layer;
    CAAnimationGroup *_animaTionGroup;
    CADisplayLink *_disPlayLink;
    UIViewController * _viewController;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.ysRadius = [[UIScreen mainScreen] bounds].size.width / 2;
        self.ysColor = [UIColor colorWithRed:arc4random()%10*0.1 green:arc4random()%10*0.1 blue:arc4random()%10*0.1 alpha:1];
    }
    return self;
}

+ (instancetype)shareYSAliPayXiuXiu
{
    static dispatch_once_t onceToken;
    static YSAliPayXiuXiuAnimation * sharedYSAliPayXiuXiu;
    dispatch_once(&onceToken, ^{
        sharedYSAliPayXiuXiu = [[self alloc] init];
    });
    return sharedYSAliPayXiuXiu;
}

#pragma mark - instance method -
- (void)showYSAliPayAnimationInViewController:(UIViewController *)viewController repeat:(BOOL)repeat
{
    _viewController = viewController;
    
    //处理属性
    // --- 半径
    if (!(self.ysRadius > 0 && self.ysRadius <= [UIScreen mainScreen].bounds.size.height/2)) {
        self.ysRadius = [UIScreen mainScreen].bounds.size.width/2;
    }
    
    // --- 颜色
    if (self.ysColor == nil) {
        self.ysColor = [UIColor colorWithRed:arc4random()%10*0.1 green:arc4random()%10*0.1 blue:arc4random()%10*0.1 alpha:1];
    }
    
    if (repeat) {    // 无限循环
        _disPlayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(delayAnimation)];
        _disPlayLink.frameInterval = 40;
        [_disPlayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }else {         // 只执行一次
        [self delayAnimation];
    }
    
}

- (void)dismissYSAliPayXiuXiu
{
    if (_disPlayLink) {
        [_disPlayLink invalidate];
        _disPlayLink = nil;
    }
}

#pragma mark - class method -
+ (void)ysAliPayXiuXiuInViewController:(UIViewController *)viewController repeat:(BOOL)repeat radius:(float)ysRadius color:(UIColor *)ysColor
{
    YSAliPayXiuXiuAnimation * ysXiuXiu = [YSAliPayXiuXiuAnimation shareYSAliPayXiuXiu];
    ysXiuXiu.ysRadius = ysRadius;
    ysXiuXiu.ysColor = ysColor;
    [ysXiuXiu showYSAliPayAnimationInViewController:viewController repeat:repeat];
}

+ (void)ysAliPayXiuXiuDismiss
{
    YSAliPayXiuXiuAnimation * ysXiuXiu = [YSAliPayXiuXiuAnimation shareYSAliPayXiuXiu];
    [ysXiuXiu dismissYSAliPayXiuXiu];
}


#pragma mark - 内部方法 -
- (void)delayAnimation
{
    [self startAnimationInViewController];
}

- (void)startAnimationInViewController
{
    CALayer *layer = [[CALayer alloc] init];
    layer.cornerRadius = self.ysRadius;
    layer.frame = CGRectMake(0, 0, layer.cornerRadius * 2, layer.cornerRadius * 2);
    layer.position = _viewController.view.layer.position;
    UIColor * color = self.ysColor;
    layer.backgroundColor = color.CGColor;
    [_viewController.view.layer addSublayer:layer];
    
    CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    _animaTionGroup = [CAAnimationGroup animation];
    _animaTionGroup.delegate = self;
    _animaTionGroup.duration = 2;
    _animaTionGroup.removedOnCompletion = YES;
    _animaTionGroup.timingFunction = defaultCurve;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    scaleAnimation.fromValue = @0.0;
    scaleAnimation.toValue = @1.0;
    scaleAnimation.duration = 2;
    
    CAKeyframeAnimation *opencityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opencityAnimation.duration = 2;
    opencityAnimation.values = @[@0.8,@0.4,@0];
    opencityAnimation.keyTimes = @[@0,@0.5,@1];
    opencityAnimation.removedOnCompletion = YES;
    
    NSArray *animations = @[scaleAnimation,opencityAnimation];
    _animaTionGroup.animations = animations;
    [layer addAnimation:_animaTionGroup forKey:nil];
    
    [self performSelector:@selector(removeLayer:) withObject:layer afterDelay:1.5];
}

- (void)removeLayer:(CALayer *)layer
{
    [layer removeFromSuperlayer];
}

@end

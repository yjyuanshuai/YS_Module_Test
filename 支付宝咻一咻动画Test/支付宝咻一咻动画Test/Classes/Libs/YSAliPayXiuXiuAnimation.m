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

- (void)showYSAliPayAnimationInViewController:(UIViewController *)viewController
{
    _viewController = viewController;
    
    _disPlayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(delayAnimation)];
    _disPlayLink.frameInterval = 40;
    [_disPlayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

#pragma mark - 内部方法
- (void)delayAnimation
{
    [self startAnimationInViewController];
}

- (void)startAnimationInViewController
{
    CALayer *layer = [[CALayer alloc] init];
    layer.cornerRadius = [UIScreen mainScreen].bounds.size.width/2;
    layer.frame = CGRectMake(0, 0, layer.cornerRadius * 2, layer.cornerRadius * 2);
    layer.position = _viewController.view.layer.position;
    UIColor *color = [UIColor colorWithRed:arc4random()%10*0.1 green:arc4random()%10*0.1 blue:arc4random()%10*0.1 alpha:1];
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

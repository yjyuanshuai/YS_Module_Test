//
//  YSCustemGesture.m
//  YS_iOS_Other
//
//  Created by YJ on 16/8/11.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSCustemGesture.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@implementation YSCustemGesture

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    _startPoint = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * currentTouch = [touches anyObject];
    CGPoint currentPoint = [currentTouch locationInView:self.view];
    
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

}

- (void)reset
{

}

- (YSDirection)returnDirection:(CGPoint)currentPoint
{
    CGFloat xSpace = currentPoint.x - _startPoint.x;
    CGFloat ySpace = currentPoint.y - _startPoint.y;
    
    if (xSpace > 0 && ySpace==0) {
        
    }
}

@end

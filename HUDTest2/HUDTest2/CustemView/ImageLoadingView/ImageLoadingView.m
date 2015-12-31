//
//  ImageLoadingView.m
//  HUDTest2
//
//  Created by YJ on 15/12/31.
//  Copyright © 2015年 YJ. All rights reserved.
//

#import "ImageLoadingView.h"

@implementation ImageLoadingView

- (instancetype)initWithView:(UIViewController *)viewController mode:(ImageLoadingViewMode)mode
{
    if (self = [super init]) {
        
        UIView * view = viewController.view;
        self.center = CGPointMake(view.center.x, view.center.y);
        
        
        
    }
    return self;
}

@end

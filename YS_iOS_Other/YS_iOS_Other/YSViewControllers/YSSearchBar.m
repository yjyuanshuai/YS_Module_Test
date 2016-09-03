//
//  YSSearchBar.m
//  YS_iOS_Other
//
//  Created by YJ on 16/9/3.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSSearchBar.h"

@implementation YSSearchBar

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (UIView * subView in self.subviews) {
        for (UIView * subSubView in subView.subviews) {
            
            if ([subSubView isKindOfClass:[UITextField class]]) {
                
            }
        }
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self registKVC];
        
    }
    return self;
}

- (void)registKVC
{
    
}

@end

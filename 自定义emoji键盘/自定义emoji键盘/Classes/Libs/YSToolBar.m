//
//  YSToolBar.m
//  自定义emoji键盘
//
//  Created by YJ on 16/2/1.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSToolBar.h"

@implementation YSToolBar
{
    CGFloat ysToolBarWidth;
    CGFloat ysToolBarHeight;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        ysToolBarWidth = frame.size.width;
        ysToolBarHeight = frame.size.height;
    }
    return self;
}

#pragma mark - 内部方法 -
- (void)setYsItems:(NSArray<UIButton *> *)ysItems
{
    for (int i = 0; i < [ysItems count]; i++) {
        
    }
}

@end

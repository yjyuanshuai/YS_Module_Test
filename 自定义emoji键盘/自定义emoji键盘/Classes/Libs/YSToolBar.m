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
    CGFloat miniBtnWidth = [[ysItems objectAtIndex:0] bounds].size.width;
    CGFloat allBtnWidth = miniBtnWidth;
    for (int i = 1; i < [ysItems count]; i++) {
        CGFloat width = [[ysItems objectAtIndex:i] bounds].size.width;
        allBtnWidth += width;
        if (miniBtnWidth > width) {
            miniBtnWidth = width;
        }
    }
    
    if (allBtnWidth > ysToolBarWidth) {
        //设置所有btn宽为最小
        CGFloat pad_x = (ysToolBarWidth - allBtnWidth)/(ysItems.count + 1);
        for (int i = 0; i < [ysItems count]; i++) {
            
        }
    }
}

@end

//
//  YSCircleScrollView.m
//  循环ScrollView
//
//  Created by YJ on 16/3/3.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSCircleScrollView.h"

@implementation YSCircleScrollView

#pragma mark - instance method
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.ysScrollView = [[UIScrollView alloc] initWithFrame:frame];
        [self addSubview:self.ysScrollView];
        
        self.ysPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((frame.size.width - 100)/2, frame.size.height - 20, 100, 20)];
        [self.ysPageControl addSubview:self.ysPageControl];
    }
    return self;
}

@end

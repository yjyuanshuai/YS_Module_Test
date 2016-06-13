//
//  YSCircleImageDisplayView.m
//  YSCircleImagesScrollView
//
//  Created by YJ on 16/1/28.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSCircleImageDisplayView.h"

@implementation YSCircleImageDisplayView

- (instancetype)initWithFrame:(CGRect)frame  imagesArr:(NSArray *)imagesArr
{
    if (self = [super initWithFrame:frame]) {
        self.imagesArr = imagesArr;
        
    }
    return self;
}

#pragma mark - 内部方法
- (void)initScrollViewWithFrame:(CGRect)frame
{
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.contentSize = CGSizeMake(frame.size.width * [self.imagesArr count], frame.size.height);
    scrollView.contentOffset = CGPointMake(0, 0);
    [self addSubview:scrollView];
}

- (void)initPageControllWithFrame:(CGRect)frame
{
    UIPageControl * pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, frame.size.height - 20, frame.size.width, 20)];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.numberOfPages = [self.imagesArr count];
    pageControl.currentPage = 0;
    [self addSubview:pageControl];
}

@end

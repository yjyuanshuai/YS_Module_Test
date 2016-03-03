//
//  YSCircleScrollView.h
//  循环ScrollView
//
//  Created by YJ on 16/3/3.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSCircleScrollView : UIView

@property (nonatomic, assign) BOOL isAutoCircle;    //是否自动循环
@property (nonatomic, assign) NSTimeInterval circleTime;    //自动循环时间，默认是1S
@property (nonatomic, strong) NSArray * images;     //循环轮播的图片组
//@property ();



@property (nonatomic, strong) UIScrollView * ysScrollView;
@property (nonatomic, strong) UIPageControl * ysPageControl;

#pragma mark - instance method
- (instancetype)initWithFrame:(CGRect)frame;

#pragma mark - class method
@end

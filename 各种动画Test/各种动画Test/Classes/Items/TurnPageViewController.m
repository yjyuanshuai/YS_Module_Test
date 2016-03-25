//
//  TurnPageViewController.m
//  各种动画Test
//
//  Created by YJ on 16/3/25.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "TurnPageViewController.h"

@interface TurnPageViewController()

@end

@implementation TurnPageViewController
{
    UIView * view;
    CATransition * tran;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createView];
    [self createStartBtn];
}

- (void)createView
{
    view = [UIView new];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(70, 10, 100, 10));
    }];
    
    tran = [CATransition animation];
    [tran setDuration:3.0];
}

- (void)createStartBtn
{
    UIButton * makeScaleBtn = [UIButton new];
    [makeScaleBtn setTitle:@"平移" forState:UIControlStateNormal];
    [makeScaleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [makeScaleBtn addTarget:self action:@selector(animationOne) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:makeScaleBtn];
    
    UIButton * rotationBtn = [UIButton new];
    [rotationBtn setTitle:@"旋转" forState:UIControlStateNormal];
    [rotationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rotationBtn addTarget:self action:@selector(animationTwo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rotationBtn];
    
    UIButton * scaleBtn = [UIButton new];
    [scaleBtn setTitle:@"缩放" forState:UIControlStateNormal];
    [scaleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [scaleBtn addTarget:self action:@selector(animationThree) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scaleBtn];
    
    UIButton * makeScaleBtn2 = [UIButton new];
    [makeScaleBtn setTitle:@"平移" forState:UIControlStateNormal];
    [makeScaleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [makeScaleBtn addTarget:self action:@selector(animationFour) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:makeScaleBtn];
    
    UIButton * rotationBtn2 = [UIButton new];
    [rotationBtn setTitle:@"旋转" forState:UIControlStateNormal];
    [rotationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rotationBtn addTarget:self action:@selector(animationFive) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rotationBtn];
    
    UIButton * scaleBtn2 = [UIButton new];
    [scaleBtn setTitle:@"缩放" forState:UIControlStateNormal];
    [scaleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [scaleBtn addTarget:self action:@selector(animationSix) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scaleBtn];
    
    [makeScaleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(30);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-10);
        
        make.centerY.equalTo(@[rotationBtn, scaleBtn, makeScaleBtn2, rotationBtn2, scaleBtn2]);
        make.size.equalTo(@[rotationBtn, scaleBtn, makeScaleBtn2, rotationBtn2, scaleBtn2]);
    }];
    
    [self.view distributeSpacingHorizontallyWith:@[makeScaleBtn, rotationBtn, scaleBtn, makeScaleBtn2, rotationBtn2, scaleBtn2]];
}

#pragma mark -
- (void)animationOne
{
    //立体旋转 cube
}

- (void)animationTwo
{
    //翻页 pageCurl/pageUnCurl
}

- (void)animationThree
{
    //水滴波纹 rippleEffect
}

- (void)animationFour
{
    //飘缩 suckEffect
}

- (void)animationFive
{
    //翻转 oglFlip
    
    [tran setType:@"oglFlip"];
    [tran setSubtype:kCATransitionFromTop];
    [view.layer addAnimation:tran forKey:nil];
}

- (void)animationSix
{

}

@end

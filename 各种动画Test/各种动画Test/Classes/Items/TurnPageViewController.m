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
    UIImageView * view;
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
    view = [UIImageView new];
    view.backgroundColor = [UIColor redColor];
    view.image = [UIImage imageNamed:@"test03"];
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
    [makeScaleBtn setTitle:@"立体旋转" forState:UIControlStateNormal];
    [makeScaleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [makeScaleBtn addTarget:self action:@selector(animationOne) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:makeScaleBtn];
    
    UIButton * rotationBtn = [UIButton new];
    [rotationBtn setTitle:@"翻页翻过" forState:UIControlStateNormal];
    [rotationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rotationBtn addTarget:self action:@selector(animationTwo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rotationBtn];
    
    UIButton * scaleBtn = [UIButton new];
    [scaleBtn setTitle:@"翻页翻回" forState:UIControlStateNormal];
    [scaleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [scaleBtn addTarget:self action:@selector(animationThree) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scaleBtn];
    
    UIButton * makeScaleBtn2 = [UIButton new];
    [makeScaleBtn2 setTitle:@"水滴波纹" forState:UIControlStateNormal];
    [makeScaleBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [makeScaleBtn2 addTarget:self action:@selector(animationFour) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:makeScaleBtn2];
    
    UIButton * rotationBtn2 = [UIButton new];
    [rotationBtn2 setTitle:@"飘缩" forState:UIControlStateNormal];
    [rotationBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rotationBtn2 addTarget:self action:@selector(animationFive) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rotationBtn2];
    
    UIButton * scaleBtn2 = [UIButton new];
    [scaleBtn2 setTitle:@"翻转" forState:UIControlStateNormal];
    [scaleBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [scaleBtn2 addTarget:self action:@selector(animationSix) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scaleBtn2];
    
    [makeScaleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(30);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-50);
        
        make.centerY.equalTo(@[rotationBtn, scaleBtn]);
        make.size.equalTo(@[rotationBtn, scaleBtn]);
    }];
    
    [self.view distributeSpacingHorizontallyWith:@[makeScaleBtn, rotationBtn, scaleBtn]];
    
    [makeScaleBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(30);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-10);
        
        make.centerY.equalTo(@[rotationBtn2, scaleBtn2]);
        make.size.equalTo(@[rotationBtn2, scaleBtn2]);
    }];
    
    [self.view distributeSpacingHorizontallyWith:@[makeScaleBtn2, rotationBtn2, scaleBtn2]];
}

#pragma mark -
- (void)animationOne
{
    //立体旋转 cube
    [tran setType:@"cube"];
    [view.layer addAnimation:tran forKey:nil];
}

- (void)animationTwo
{
    //翻页 pageCurl/pageUnCurl
    [tran setType:@"pageCurl"];
    [tran setSubtype:kCATransitionFromRight];
    [view.layer addAnimation:tran forKey:nil];
}

- (void)animationThree
{
    //翻页 pageCurl/pageUnCurl
    [tran setType:@"pageUnCurl"];
    [tran setSubtype:kCATransitionFromLeft];
    [view.layer addAnimation:tran forKey:nil];
}

- (void)animationFour
{
    //水滴波纹 rippleEffect
    [tran setType:@"rippleEffect"];
    [view.layer addAnimation:tran forKey:nil];
}

- (void)animationFive
{
    //飘缩 suckEffect
    [tran setType:@"suckEffect"];
    [view.layer addAnimation:tran forKey:nil];
}

- (void)animationSix
{
    //翻转 oglFlip
    [tran setType:@"oglFlip"];
    [tran setSubtype:kCATransitionFromTop];
    [view.layer addAnimation:tran forKey:nil];

}

@end

//
//  CoreAnimationViewController.m
//  各种动画Test
//
//  Created by YJ on 16/3/29.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "CoreAnimationViewController.h"
#import "Masonry.h"

@interface CoreAnimationViewController ()

@end

@implementation CoreAnimationViewController
{
    UIImageView * _imageView;
    
    CABasicAnimation * _baseAnimation1;
    CABasicAnimation * _baseAnimation2;
    
    CAKeyframeAnimation * _keyFrameAnimation1;
    CAKeyframeAnimation * _keyFrameAnimation2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createStartBtn
{
    UIButton * makeScaleBtn = [UIButton new];
    [makeScaleBtn setTitle:@"base单个" forState:UIControlStateNormal];
    [makeScaleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [makeScaleBtn addTarget:self action:@selector(animationOne) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:makeScaleBtn];
    
    UIButton * rotationBtn = [UIButton new];
    [rotationBtn setTitle:@"base组合" forState:UIControlStateNormal];
    [rotationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rotationBtn addTarget:self action:@selector(animationTwo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rotationBtn];
    
    UIButton * scaleBtn = [UIButton new];
    [scaleBtn setTitle:@"关键帧" forState:UIControlStateNormal];
    [scaleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [scaleBtn addTarget:self action:@selector(animationThree) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scaleBtn];
    
    UIButton * makeScaleBtn2 = [UIButton new];
    [makeScaleBtn2 setTitle:@"路径" forState:UIControlStateNormal];
    [makeScaleBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [makeScaleBtn2 addTarget:self action:@selector(animationFour) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:makeScaleBtn2];
    
    UIButton * rotationBtn2 = [UIButton new];
    [rotationBtn2 setTitle:@"暂无" forState:UIControlStateNormal];
    [rotationBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rotationBtn2 addTarget:self action:@selector(animationFive) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rotationBtn2];
    
    UIButton * scaleBtn2 = [UIButton new];
    [scaleBtn2 setTitle:@"暂无" forState:UIControlStateNormal];
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

- (void)createImageView
{
    _imageView = [UIImageView new];
    _imageView.image = [UIImage imageNamed:@"test04"];
    [self.view addSubview:_imageView];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(70, 10, 100, 10));
    }];
    
    [self createStartBtn];
}

- (void)createCABasicAnimation1
{
    /**
     *  单个动画
     */
    
    
    _baseAnimation1 = [CABasicAnimation animationWithKeyPath:@"contents"];
    //设置动画需改变的值
//    _baseAnimation1.fromValue = (id)[UIImage imageNamed:@"test04"].CGImage;
    _baseAnimation1.toValue = (id)[UIImage imageNamed:@"test03"].CGImage;
    //时间
    _baseAnimation1.duration = 1.0;
    //
//    _baseAnimation1.autoreverses = NO;
    _baseAnimation1.removedOnCompletion = NO;
    _baseAnimation1.fillMode = kCAFillModeForwards;
    [_imageView.layer addAnimation:_baseAnimation1 forKey:nil];
}

- (void)createCABasicAnimation2
{
    /**
     *  组合动画
     */
    
    
    
    _baseAnimation1 = [CABasicAnimation animationWithKeyPath:@"contents"];
    //设置动画需改变的值
    _baseAnimation1.toValue = (id)[UIImage imageNamed:@"test03"].CGImage;
    
    
    _baseAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    _baseAnimation2.fromValue = [NSNumber numberWithFloat:1.0];
    _baseAnimation2.toValue = [NSNumber numberWithFloat:0.3];
    
    CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = 2.0;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.animations = @[_baseAnimation1, _baseAnimation2];
    
    [_imageView.layer addAnimation:animationGroup forKey:nil];
}

- (void)createCAKeyframeAnimation1  // 关键帧
{
    
}

- (void)createCAKeyframeAnimation2  // 路径
{
    //初始化路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, 0);
    CGPathAddCurveToPoint(path, nil,
                          20, 40,
                          40, 80,
                          60, 100);
    
    _keyFrameAnimation2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    _keyFrameAnimation2.path = path;
    _keyFrameAnimation2.duration = 2.0;
    
    //渐出
    _keyFrameAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    //自动旋转方向
    _keyFrameAnimation2.rotationMode = @"auto";
    
    [_imageView.layer addAnimation:_keyFrameAnimation2 forKey:nil];
}

#pragma mark -
- (void)animationOne
{
    [self createCABasicAnimation1];
}

- (void)animationTwo
{
    [self createCABasicAnimation2];
}

- (void)animationThree
{
    [self createCAKeyframeAnimation1];
}

- (void)animationFour
{
    [self createCAKeyframeAnimation2];
}

- (void)animationFive
{

}

- (void)animationSix
{

}

@end

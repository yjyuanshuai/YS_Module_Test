//
//  TwoDemotionViewController.m
//  各种动画Test
//
//  Created by YJ on 16/3/25.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "TwoDemotionViewController.h"

@interface TwoDemotionViewController ()

@end

@implementation TwoDemotionViewController
{
    UIView * squareView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createSquare];
    [self createStartBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createSquare
{
    UIView * bgView = [UIView new];
    bgView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:bgView];

    squareView = [UIView new];
    squareView.backgroundColor = [UIColor redColor];
    [bgView addSubview:squareView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(65, 10, 50, 10));
    }];
    
    [squareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
        make.top.equalTo(bgView).with.offset(0);
        make.left.equalTo(bgView).with.offset(0);
    }];
}

- (void)createStartBtn
{
    UIButton * makeScaleBtn = [UIButton new];
    [makeScaleBtn setTitle:@"平移" forState:UIControlStateNormal];
    [makeScaleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [makeScaleBtn addTarget:self action:@selector(makeScale) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:makeScaleBtn];
    
    UIButton * rotationBtn = [UIButton new];
    [rotationBtn setTitle:@"旋转" forState:UIControlStateNormal];
    [rotationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rotationBtn addTarget:self action:@selector(rotation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rotationBtn];
    
    UIButton * scaleBtn = [UIButton new];
    [scaleBtn setTitle:@"缩放" forState:UIControlStateNormal];
    [scaleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [scaleBtn addTarget:self action:@selector(scale) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scaleBtn];
    
    [makeScaleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(30);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-10);
        
        make.centerY.equalTo(@[rotationBtn, scaleBtn]);
        make.size.equalTo(@[rotationBtn, scaleBtn]);
    }];
    
//    [rotationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//    }];
//    
//    [scaleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//    }];
    
    [self.view distributeSpacingHorizontallyWith:@[makeScaleBtn, rotationBtn, scaleBtn]];
}

#pragma mark - 
- (void)makeScale
{
    //
    squareView.transform = CGAffineTransformTranslate(squareView.transform, 10, 10);
}

- (void)rotation
{
    squareView.transform = CGAffineTransformRotate(squareView.transform, M_PI_4);
}

- (void)scale
{
    squareView.transform = CGAffineTransformScale(squareView.transform, -2, -2);
}

@end

//
//  YSPlayViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/28.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSPlayViewController.h"

@interface YSPlayViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView * bgImageView;
@property (nonatomic, strong) UIScrollView * audioScrollView;
@property (nonatomic, strong) UIImageView * audioImageView;

@end

@implementation YSPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self createUI];
    [self createShapeLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    self.title = @"播放器";
}

- (void)createShapeLayer
{
    CGFloat height = 150;
    CGFloat space = 30;
    
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    
    CGPoint p1 = CGPointMake(0, self.view.frame.size.height - height);
    CGPoint p2 = CGPointMake(0, self.view.frame.size.height);
    CGPoint p3 = CGPointMake(kScreenWidth, self.view.frame.size.height);
    CGPoint p4 = CGPointMake(kScreenWidth, self.view.frame.size.height - height);
    CGPoint control1 = CGPointMake(kScreenWidth/2, self.view.frame.size.height - height - space);
    
    [bezierPath moveToPoint:p1];
    [bezierPath addLineToPoint:p2];
    [bezierPath addLineToPoint:p3];
    [bezierPath addLineToPoint:p4];
    [bezierPath addQuadCurveToPoint:p1 controlPoint:control1];
    
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.fillColor = [UIColor blackColor].CGColor;
    shapeLayer.borderColor = [UIColor blackColor].CGColor;
    
    [self.view.layer addSublayer:shapeLayer];
}

- (void)createUI
{
    _bgImageView = [UIImageView new];
    _bgImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"audioPlayer_bg" ofType:@"jpg"]];
    [self.view addSubview:_bgImageView];
    
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
//    _audioScrollView = [UIScrollView new];
//    _audioScrollView.delegate = self;
//    _audioScrollView.contentSize = CGSizeMake(3 * kScreenWidth, kScreenWidth);
//    [self.view addSubview:_audioScrollView];
//    
//    [_audioScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).mas_offset(0);
//        make.left.equalTo(self.view).mas_offset(0);
//        make.size.mas_equalTo(CGSizeMake(kScreenWidth, kScreenWidth));
//    }];
    
    _audioImageView = [UIImageView new];
    _audioImageView.image = [UIImage imageNamed:@"audioPlayer_image"];
    _audioImageView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_audioImageView];
    
    [_audioImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 30, kScreenWidth - 30));
        make.top.equalTo(self.view).mas_offset(15);
    }];
    
    
}

- (void)createUpBtn
{
    UIButton * collectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [collectionBtn setBackgroundImage:[UIImage imageNamed:@"cm2_fm_btn_love"] forState:UIControlStateNormal];
    [collectionBtn setBackgroundImage:[UIImage imageNamed:@"cm2_fm_btn_loved"] forState:UIControlStateSelected];
    [collectionBtn setBackgroundImage:[UIImage imageNamed:@"cm2_fm_btn_loved_dis"] forState:UIControlStateDisabled];
    [collectionBtn addTarget:self action:@selector(clickCollectionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:collectionBtn];
    
    
    UIButton * downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [downloadBtn setBackgroundImage:[UIImage imageNamed:@"cm2_icn_dld_prs"] forState:UIControlStateNormal];
    [downloadBtn setBackgroundImage:[UIImage imageNamed:@"cm2_icn_dlded_prs"] forState:UIControlStateSelected];
    [downloadBtn setBackgroundImage:[UIImage imageNamed:@"cm2_icn_dld_dis"] forState:UIControlStateDisabled];
    [downloadBtn addTarget:self action:@selector(clickDownloadBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:downloadBtn];
    
    UIButton * collectionBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [collectionBtn2 setBackgroundImage:[UIImage imageNamed:@"cm2_fm_btn_love"] forState:UIControlStateNormal];
    [collectionBtn2 setBackgroundImage:[UIImage imageNamed:@"cm2_fm_btn_loved"] forState:UIControlStateSelected];
    [collectionBtn2 setBackgroundImage:[UIImage imageNamed:@"cm2_fm_btn_loved_dis"] forState:UIControlStateDisabled];
    //    [collectionBtn2 addTarget:self action:@selector(clickCollectionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:collectionBtn2];
    
    UIButton * downloadBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [downloadBtn2 setBackgroundImage:[UIImage imageNamed:@"cm2_icn_dld_prs"] forState:UIControlStateNormal];
    [downloadBtn2 setBackgroundImage:[UIImage imageNamed:@"cm2_icn_dlded_prs"] forState:UIControlStateSelected];
    [downloadBtn2 setBackgroundImage:[UIImage imageNamed:@"cm2_icn_dld_dis"] forState:UIControlStateDisabled];
    //    [downloadBtn2 addTarget:self action:@selector(clickDownloadBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:downloadBtn2];
    
    [collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).mas_equalTo(-120);
        make.left.equalTo(self.view).mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    CGFloat space = (kScreenWidth - 30 - 4*40)/3;
    
    [downloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).mas_equalTo(-120);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.equalTo(collectionBtn).mas_equalTo(space + 40);
    }];
    
    [collectionBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).mas_equalTo(-120);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.equalTo(downloadBtn).mas_equalTo(space + 40);
    }];
    
    [downloadBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).mas_equalTo(-120);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.equalTo(collectionBtn2).mas_equalTo(space + 40);
    }];
}

- (void)createDownBtn
{
    
}

- (void)clickCollectionBtn:(UIButton *)sender
{
    sender.selected = !sender.selected;
}

- (void)clickDownloadBtn:(UIButton *)sender
{
    
}

@end

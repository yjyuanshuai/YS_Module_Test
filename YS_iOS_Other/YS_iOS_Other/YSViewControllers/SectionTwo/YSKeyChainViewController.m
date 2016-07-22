//
//  YSKeyChainViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/22.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSKeyChainViewController.h"

@interface YSKeyChainViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * kcScrollView;
@property (nonatomic, strong) UIView * kcContentView;
@property (nonatomic, strong) UITextField * kcNameTf;
@property (nonatomic, strong) UITextField * kcPassWordTf;
@property (nonatomic, strong) UILabel * ysContentLabel;

@end

@implementation YSKeyChainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self createScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    self.title = @"keychain";
}

- (void)createScrollView
{
    _kcScrollView = [UIScrollView new];
    _kcScrollView.delegate = self;
    _kcScrollView.contentSize = CGSizeMake(kScreenWidth, self.view.frame.size.height);
    [self.view addSubview:_kcScrollView];
    
    _kcContentView = [UIView new];
    _kcContentView.backgroundColor = [UIColor orangeColor];
    [_kcScrollView addSubview:_kcContentView];
}

- (void)addContaintToScrollView
{
    
}


@end

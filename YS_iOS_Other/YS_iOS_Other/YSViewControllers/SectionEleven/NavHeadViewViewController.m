//
//  NavHeadViewViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/29.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "NavHeadViewViewController.h"

@interface NavHeadViewViewController ()

@property (nonatomic, strong) UIImageView * headImageView;
@property (nonatomic, strong) UIScrollView * scrollView;

@end

@implementation NavHeadViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createScrollView];
    [self createHeadImageView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createHeadImageView
{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"11" ofType:@"jpg"];
    
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    _headImageView.image = [UIImage imageWithContentsOfFile:path];
    
    self.navigationItem.titleView = _headImageView;
}

- (void)createScrollView
{
    _scrollView = [UIScrollView new];
    [self.view addSubview:_scrollView];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

@end

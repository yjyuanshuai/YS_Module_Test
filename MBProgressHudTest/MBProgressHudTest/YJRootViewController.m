//
//  YJRootViewController.m
//  MBProgressHudTest
//
//  Created by YJ on 15/12/25.
//  Copyright © 2015年 YJ. All rights reserved.
//

#import "YJRootViewController.h"
#import "YYAnimationIndicator.h"
#import "YJLoadingView.h"

@interface YJRootViewController ()

@end

@implementation YJRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = [UIColor redColor];
    [self initUI2];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI2
{
    YJLoadingView * loadingVC2 = [[YJLoadingView alloc] initWithFrame:self.view.frame];
    [loadingVC2 showLoadingView];
//    loadingVC2.loadViewSize = CGSizeMake(300, 300);
    loadingVC2.timeOverInterval = 3;
//    loadingVC2.loadViewType = YJLoadingViewTypeImage;
    [self.view addSubview:loadingVC2];
}

@end

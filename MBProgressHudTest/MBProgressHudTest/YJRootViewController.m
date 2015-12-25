//
//  YJRootViewController.m
//  MBProgressHudTest
//
//  Created by YJ on 15/12/25.
//  Copyright © 2015年 YJ. All rights reserved.
//

#import "YJRootViewController.h"
#import "YXSpritesLoadingView.h"

@interface YJRootViewController ()

@end

@implementation YJRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI
{
    [self.view endEditing:YES];
    [YXSpritesLoadingView showWithText:@"医宝" andShimmering:NO andBlurEffect:YES];
}

@end

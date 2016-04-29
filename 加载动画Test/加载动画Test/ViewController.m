//
//  ViewController.m
//  加载动画Test
//
//  Created by YJ on 16/4/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"
#import "YSActivityIndicator.h"
#import "YSActivityIndicatorManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor greenColor];
    self.title = @"这是第一个";
    
    UIBarButtonItem * startBtn = [[UIBarButtonItem alloc] initWithTitle:@"开始" style:UIBarButtonItemStylePlain target:self action:@selector(startLoading)];
    
    UIBarButtonItem * stopBtn = [[UIBarButtonItem alloc] initWithTitle:@"停止" style:UIBarButtonItemStylePlain target:self action:@selector(stopLoading)];
    
    self.navigationItem.leftBarButtonItem = startBtn;
    self.navigationItem.rightBarButtonItem = stopBtn;
    
//    YSActivityIndicator * loadingView = [YSActivityIndicator showInViewController:self];
//    loadingView.ysType = YSLoadViewTypeSystemActIndicatorDefault;
//    loadingView.ysActivityIndicatorStyle = UIActivityIndicatorViewStyleGray;
//    loadingView.titleStr = @"正在加载...";
//    loadingView.titleTextColor = [UIColor blackColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [YSActivityIndicatorManager addDetailIndicatorInController:self
                                                      titleStr:@"加载中..."
                                                          desc:@"加载描述，网络正在加载请稍后"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startLoading
{
    
}

- (void)stopLoading
{
    [YSActivityIndicatorManager hideInController:self];
}

@end

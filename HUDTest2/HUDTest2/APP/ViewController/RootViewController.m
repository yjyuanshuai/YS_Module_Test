//
//  RootViewController.m
//  HUDTest2
//
//  Created by YJ on 15/12/31.
//  Copyright © 2015年 YJ. All rights reserved.
//

#import "RootViewController.h"
#import "ImageLoadingView.h"
#import "FeWifiManHub.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UILabel * label = [[UILabel alloc] init];
    label.bounds = CGRectMake(0, 0, 300, 400);
    label.center = CGPointMake(self.view.center.x, self.view.center.y);
    label.text = @"阿虎会飞恩还得解放军";
    label.font = [UIFont systemFontOfSize:30];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    [self startAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startAnimation
{
    FeWifiManHub * loadingView = [[FeWifiManHub alloc] initWithView:self.view withMode:FeWifiManHubModeOnlyLoader];
    
    [[UIApplication sharedApplication].keyWindow addSubview:loadingView];
    [loadingView setNeedsDisplay];
    
    [loadingView showWhileExecutingBlock:^{
        sleep(100);
    } completion:^{
        
    }];
}

@end

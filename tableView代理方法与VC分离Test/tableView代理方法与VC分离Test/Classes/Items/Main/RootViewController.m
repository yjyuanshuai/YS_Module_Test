//
//  RootViewController.m
//  tableView代理方法与VC分离Test
//
//  Created by YJ on 16/1/25.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI
{
    UIButton * one = [UIButton buttonWithType:UIButtonTypeCustom];
    one.frame = CGRectMake(0, 20, 100, 30);
    one.backgroundColor = [UIColor blackColor];
    [self.view addSubview:one];
    
    UIButton * two = [UIButton buttonWithType:UIButtonTypeCustom];
    two.frame = CGRectMake(110, 20, 100, 30);
    two.backgroundColor = [UIColor blueColor];
    [self.view addSubview:two];
    
    
}

@end

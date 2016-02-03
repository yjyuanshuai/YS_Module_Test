//
//  ViewController.m
//  YSQQYiJianTuiChao
//
//  Created by YJ on 16/2/3.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"
#import "YSQQRedBallCanvas.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    YSQQRedBallCanvas * ysCanva = [[YSQQRedBallCanvas alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [self.view addSubview:ysCanva];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

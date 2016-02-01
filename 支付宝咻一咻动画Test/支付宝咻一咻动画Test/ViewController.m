//
//  ViewController.m
//  支付宝咻一咻动画Test
//
//  Created by YJ on 16/1/30.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"
#import "YSAliPayXiuXiuAnimation.h"

@interface ViewController ()
- (IBAction)animation:(UIButton *)sender;
- (IBAction)stop:(UIButton *)sender;

@end

@implementation ViewController
{
    YSAliPayXiuXiuAnimation * an;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
}

- (IBAction)animation:(UIButton *)sender {
    
    an = [[YSAliPayXiuXiuAnimation alloc] init];
    an.ysColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
    an.ysRadius = 200;
    [an showYSAliPayAnimationInViewController:self repeat:NO];
//    [YSAliPayXiuXiuAnimation ysAliPayXiuXiuInViewController:self repeat:NO radius:100 color:nil];
    
}

- (IBAction)stop:(UIButton *)sender {
    
//    [an dismissYSAliPayXiuXiu];
    [YSAliPayXiuXiuAnimation ysAliPayXiuXiuDismiss];
}
@end

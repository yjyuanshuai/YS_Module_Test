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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
}

- (IBAction)animation:(UIButton *)sender {
    
    YSAliPayXiuXiuAnimation * an = [[YSAliPayXiuXiuAnimation alloc] init];
    [an showYSAliPayAnimationInViewController:self];
    
}
@end

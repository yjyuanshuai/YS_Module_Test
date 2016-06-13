//
//  YSRootViewController.m
//  二维码生成与扫描Test
//
//  Created by YJ on 16/1/20.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSRootViewController.h"
#import "YSQRCodeImageView.h"
#import "YSBarCodeImageView.h"
#import "YSSquareScanCodeViewController.h"

static CGFloat moreHeight = 50;

@interface YSRootViewController ()

@end

@implementation YSRootViewController
{
    UILabel * _codeLabel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 生成二维码
    [YSQRCodeImageView qrImageViewWithFrame:CGRectMake((ScreenWidth - 200)/2, 20+moreHeight, 200, 200) String:@"https://www.baidu.com" viewController:self];
    
    
    // 生成条形码
    [YSBarCodeImageView bcImageViewWithFrame:CGRectMake((ScreenWidth - 150)/2, 250+moreHeight, 150, 50) string:@"6926292924425" viewController:self];
    
    
    // 显示扫描得到的二维码/条形码内容
    _codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 350+moreHeight, ScreenWidth - 40, 50)];
    _codeLabel.textColor = [UIColor blackColor];
    _codeLabel.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:_codeLabel];
    
    
    
    UIButton * qrButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    qrButton2.frame = CGRectMake(40, 420+moreHeight, ScreenWidth - 80, 30);
    qrButton2.backgroundColor = [UIColor lightGrayColor];
    [qrButton2 setTitle:@"正方形扫描" forState:UIControlStateNormal];
    [qrButton2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [qrButton2 addTarget:self action:@selector(scanSquare) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qrButton2];
    
}

#pragma mark - 扫描
- (void)scanSquare
{
    YSSquareScanCodeViewController * ysSquareVC = [[YSSquareScanCodeViewController alloc] initWithBlock:^(NSString * codeText) {

        _codeLabel.text = codeText;
    }];
    
    [self.navigationController pushViewController:ysSquareVC animated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

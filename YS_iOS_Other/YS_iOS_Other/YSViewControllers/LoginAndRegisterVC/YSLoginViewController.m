//
//  YSLoginViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSLoginViewController.h"
#import "YSScrollView.h"

@interface YSLoginViewController ()

@property (nonatomic, strong) YSScrollView * scrollView;
@property (nonatomic, strong) UITextField * nameTextFeild;
@property (nonatomic, strong) UITextField * passWordTextFeild;
@property (nonatomic, strong) UIButton * loginBtn;
@property (nonatomic, strong) UIButton * registerBtn;

@end

@implementation YSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createScrollView];
    [self createNameAndPassWord];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createScrollView
{
    _scrollView = [[YSScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    _scrollView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_scrollView];
}

- (void)createNameAndPassWord
{
    _nameTextFeild = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_scrollView.frame) + 20, kScreenWidth - 20, 40)];
    _nameTextFeild.placeholder = @"姓名";
    _nameTextFeild.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_nameTextFeild];
    
    
    _passWordTextFeild = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_nameTextFeild.frame) + 20, kScreenWidth - 20, 40)];
    _passWordTextFeild.placeholder = @"密码";
    _passWordTextFeild.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_passWordTextFeild];
    
    CGFloat btnWdth = (kScreenWidth - 20 - 80)/2;
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.frame = CGRectMake(10, CGRectGetMaxY(_passWordTextFeild.frame), btnWdth, 40);
    [_loginBtn addTarget:self action:@selector(clickToLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    
    _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _registerBtn.frame = CGRectMake(kScreenWidth - 10 - btnWdth, CGRectGetMaxY(_passWordTextFeild.frame), btnWdth, 40);
    [_registerBtn addTarget:self action:@selector(clickToRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registerBtn];
}

- (void)clickToLogin
{

}

- (void)clickToRegister
{

}

@end

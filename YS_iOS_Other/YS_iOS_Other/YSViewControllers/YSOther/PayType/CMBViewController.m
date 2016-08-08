//
//  CMBViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/8/8.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "CMBViewController.h"

@interface CMBViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView * webView;

@end

@implementation CMBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self createWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    self.title = @"测试";
}

- (void)createWebView
{
    _webView = [UIWebView new];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    NSString * testPath = @"http://61.144.248.29:801/mobilehtml/DebitCard/M_NetPay/OneNetRegister/NP_BindCard.aspx";
    NSString * tesstPara = [NSString stringWithFormat:@"?REQSERIAL=XXX&CUSTARGNO=XXX&MERCHANTNO=XXX&MOBILE=XXX&USERID=XXX&LON=XXX&LAT=XXX&RISKLEVEL=XXX&TIMESTAMP=XXX&NOTICEURL=XXX&NOTICEPARA=XXX"];
    
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{

}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{

}

@end

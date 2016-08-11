//
//  CMBViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/8/8.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "CMBViewController.h"
#import "YSEnDecryptionMethod.h"

@interface CMBViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView * cmbWebView;

@end

@implementation CMBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self createWebView];
    [self userContract];
    [self userPay];
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
    _cmbWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeightNo64)];
    _cmbWebView.delegate = self;
    _cmbWebView.dataDetectorTypes = UIDataDetectorTypeNone;
    [self.view addSubview:_cmbWebView];
}

- (void)userContract
{
    NSString * cmbURlStr = @"http://61.144.248.29:801/mobilehtml/DebitCard/M_NetPay/OneNetRegister/NP_BindCard.aspx";
    
    // 交易流水号
    NSString * reqserial = @"201608100000000000000000";
    // 客户协议号
    NSString * custaragno = @"00000000010000000001000000000111";
    // 企业网银号
    NSString * merchantno = @"P0021539";
    // 交易时间
    NSString * timestamp = @"20160810141611"; //20150812154711
    // 商户接受签约设置结果
    NSString * noticeURL = @"http://merchant.com/recv.aspx";
    
    NSString * privateKey = @"cmbsh29i";
    // DES密文
    NSString * signPara = [NSString stringWithFormat:@"REQSERIAL=%@&CUSTARGNO=%@&MERCHANTNO=%@&MOBILE=&USERID=&LON=&LAT=&RISKLEVEL=&TIMESTAMP=%@&NOTICEURL=%@&NOTICEPARA=", reqserial, custaragno, merchantno, timestamp, noticeURL];
    
    NSString * signDESStr = [YSEnDecryptionMethod encryptDESStrForSting:signPara key:privateKey andDesiv:privateKey];
    
    NSURL * cmbUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@?SIGN=%@", cmbURlStr, signDESStr]];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:cmbUrl];
    [_cmbWebView loadRequest:request];
}

- (void)userPay
{
    /*
     http://61.144.248.29:801/netpayment/BaseHttp.dll?PrePayEUserP?
     BranchID=0010
     &CoNo=000186
     &BillNo=0000000028
     &Amount=1000.00
     &Date=20160811
     &ExpireTimeSpan=
     &MerchantUrl=http://merchant.com/recv.aspx
     &MerchantPara=abc
     &MerchantCode=|VULqT4yvOBE7qTw*ifSzbC2vYMcmwcTTeeGQyd1HYgejdB4XkURvRXxGB3vczpz47BpcO28ByCKilylT6JplJoLu1SGdPP2IOy6fQn7hGZrt4z7moS8gh27A75kOn*lp3ch/2B71dObax/8SXY2wtxrQ9rOfN/ry5Zak4ydZBrjyG/g92kPRsNtB*5bb0MNzJqDe/KxLmBBW7i4PIqH6zr14MZZuXP6na0Sc/oJU1DJhdRuHQ02yx3UxEwVS1Is7dNbKilIjRFMAh4FxyCtMrP4PC7yriFBvzchym7GZ3ki7dtbYfvNBJRExLkHlexou3yu7KaCE0z9Z5QciFWi**G///sk5mTA*msHxLhFv8JnK3Y88yH8FfhPYwoWK15WaCg4uvCMDET44lIOxDOImmXWNJ4zHs85Mb7UCtQy6WynMueryLk6QzcthH/G3xo4ZBc1q4R6TYv8mySZIGhQ9HhAAFWNkQLWh|522583d556e49bec8980d8fc0ef2ab915f53c265
     &MerchantRetUrl=http://merchant.com/recv.aspx
     &MerchantRetPara=abc
     */
    
    NSString * cmbUrlStr = @"http://61.144.248.29:801/netpayment/BaseHttp.dll?PrePayEUserP?";
    
    NSString * branchID = @"0010";  // 分行号
    NSString * coNo = @"000186";  // 商户号
    NSString * billNo = @"0000000001";  // 订单号
    NSString * amount = @"0.01";        // 订单总价
    NSString * data = @"20160811";
//    NSString * expireTimeSpan = @"";
    NSString * merchantUrl = @"http://merchant.com/recv.aspx";
    NSString * merchantPara = @"abc";
    NSString * merchantCode = @"|VULqT4yvOBE7qTw*ifSzbC2vYMcmwcTTeeGQyd1HYgejdB4XkURvRXxGB3vczpz47BpcO28ByCKilylT6JplJoLu1SGdPP2IOy6fQn7hGZrt4z7moS8gh27A75kOn*lp3ch/2B71dObax/8SXY2wtxrQ9rOfN/ry5Zak4ydZBrjyG/g92kPRsNtB*5bb0MNzJqDe/KxLmBBW7i4PIqH6zr14MZZuXP6na0Sc/oJU1DJhdRuHQ02yx3UxEwVS1Is7dNbKilIjRFMAh4FxyCtMrP4PC7yriFBvzchym7GZ3ki7dtbYfvNBJRExLkHlexou3yu7KaCE0z9Z5QciFWi**G///sk5mTA*msHxLhFv8JnK3Y88yH8FfhPYwoWK15WaCg4uvCMDET44lIOxDOImmXWNJ4zHs85Mb7UCtQy6WynMueryLk6QzcthH/G3xo4ZBc1q4R6TYv8mySZIGhQ9HhAAFWNkQLWh|522583d556e49bec8980d8fc0ef2ab915f53c265";      // 商户校验码
    NSString * merchantRetUrl = @"http://merchant.com/recv.aspx";
    NSString * merchantRetPara = @"abc";
    
    
    
    NSString * cmbPayPara = [NSString stringWithFormat:@"BranchID=%@&CoNo=%@&BillNo=%@&Amount=%@&Date=%@&ExpireTimeSpan=&MerchantUrl=%@&MerchantPara=&MerchantCode=%@&MerchantRetUrl=%@&MerchantRetPara=%@", branchID, coNo, billNo, amount, data, merchantUrl, merchantPara, merchantCode, merchantRetUrl, merchantRetPara];
    
    NSString * cmbUrl = [NSString stringWithFormat:@"%@%@", cmbUrlStr, cmbPayPara];
    NSURL * cmbURL = [NSURL URLWithString:cmbUrl];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:cmbURL];
    [_cmbWebView loadRequest:request];
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *requestString = [request.URL absoluteString];

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

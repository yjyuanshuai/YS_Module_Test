//
//  ViewController.m
//  iOS 与 JS 交互Test
//
//  Created by YJ on 16/1/26.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *ysWebView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initWebView
{
    self.ysWebView.delegate = self;
    [self.ysWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
}

#pragma mark - WebViewDelegate 
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    /**
     *  网页加载前会调用
     *  yes 表示正常加载， no 表示停止加载
     */
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    /**
     *  开始加载网页时调用
     */
    
    // iOS 调用 JS
    // 0、导入 JavaScriptCore 框架
    // 1、创建 JSContext 对象
    JSContext * jsContext = [self.ysWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    // 2、通过oc方法调用js的alert
    NSString * alertJS = @"alert(执行js代码)";
    [jsContext evaluateScript:alertJS];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    /**
     *  网页加载完成
     */
    
    // JS 调用 iOS (2种方法)
    // 第一种（JS直接调用方法）
    
    
    // 第二种（JS通过对象调用方法）


}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    /**
     *  网页加载失败
     */
}


@end

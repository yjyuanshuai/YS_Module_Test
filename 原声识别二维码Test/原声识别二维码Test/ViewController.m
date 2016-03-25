//
//  ViewController.m
//  原声识别二维码Test
//
//  Created by YJ on 16/3/24.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"
#import "YSCodeImageView.h"

@interface ViewController ()<UITextViewDelegate>

@end

@implementation ViewController
{
    UILabel * _label;
    YSCodeImageView * _imageView;
    YSCodeImageView * _barImageView;
    
    UITextView * _originTextView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self createOriginStr];
    [self createResultStr];
    [self createImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createOriginStr
{
    //待生成的二维码，源数据
    _originTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 40, self.view.frame.size.width - 100, 40)];
    _originTextView.backgroundColor = [UIColor lightGrayColor];
    _originTextView.delegate = self;
    [self.view addSubview:_originTextView];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(self.view.frame.size.width - 100, 40, 90, 40);
    [btn setTitle:@"生成" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)createResultStr
{
    _label = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, self.view.frame.size.width - 100, 40)];
    _label.textAlignment = NSTextAlignmentLeft;
    _label.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_label];
}

- (void)createImageView
{
    _imageView = [[YSCodeImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 100)/2, 150, 100, 100) type:YSCodeImageViewTypeQR];
    _imageView.layer.borderColor = [UIColor redColor].CGColor;
    _imageView.layer.borderWidth = 1;
    [self.view addSubview:_imageView];
    
    UILongPressGestureRecognizer * tap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(clickImageView)];
    [_imageView addGestureRecognizer:tap];
    
    
    _barImageView = [[YSCodeImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 100)/2, 280, 100, 60) type:YSCodeImageViewTypeBar];
    [self.view addSubview:_barImageView];
    
    UILongPressGestureRecognizer * tap2 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(clickBarImageView)];
    [_barImageView addGestureRecognizer:tap2];
}

#pragma mark - 
- (void)clickBtn
{
    //生成
    [self.view endEditing:YES];
    [_imageView createQRCodeWithStr:_originTextView.text];
    [_barImageView createBarCodeWithStr:_originTextView.text];
}

- (void)clickImageView
{
    //识别
    _label.text = [_imageView recgoniteCode];
}

- (void)clickBarImageView
{
    _label.text = [_imageView recgoniteCode];
}

#pragma mark - UITextViewDelegate -

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

@end

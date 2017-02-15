//
//  ViewController.m
//  YSImagePickerController
//
//  Created by YJ on 17/2/14.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "ViewController.h"
#import "YSImagePickerController.h"

@interface ViewController ()<YSImagePickerDelegate>

@end

@implementation ViewController
{
    UIButton * btn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 40);
    [btn setTitle:@"调用" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickLibrary:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickLibrary:(UIButton *)clickBtn
{
    YSImagePickerController * imagePickVC = [[YSImagePickerController alloc] initWithMaxCount:10 delegate:self];
//    imagePickVC.showPickerView = YES;
    [self presentViewController:imagePickVC animated:YES completion:nil];
}

#pragma mark - YSImagePickerDelegate



@end

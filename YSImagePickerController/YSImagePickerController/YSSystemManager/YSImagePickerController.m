//
//  YSImagePickerController.m
//  YSImagePickerController
//
//  Created by YJ on 17/2/14.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSImagePickerController.h"
#import "YSImagePickerHead.h"
#import "YSAlbumsViewController.h"
#import "YSPhotosViewController.h"

@interface YSImagePickerController ()

@end

@implementation YSImagePickerController

#pragma mark - init
// 选择图片、视频
- (instancetype)initWithMaxCount:(NSInteger)maxCount delegate:(id<YSImagePickerDelegate>)delegate
{
    return [self initWithMaxCount:maxCount colument:4 delegate:delegate];
}

- (instancetype)initWithMaxCount:(NSInteger)maxCount colument:(NSInteger)colument delegate:(id<YSImagePickerDelegate>)delegate
{
    YSAlbumsViewController * albumsVC = [[YSAlbumsViewController alloc] init];
    
    self = [super initWithRootViewController:albumsVC];
    if (self) {
        
        self.maxCount = maxCount;
        self.columentNum = colument;
        self.imageDelegate = delegate;
        
    }
    return self;
}

#pragma mark - 
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationBar.translucent = YES;
    [self initValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - init
- (void)initValue
{
    self.maxCount = (self.maxCount > 0) ? self.maxCount : 9;
    self.columentNum = (self.columentNum > 0) ? self.columentNum : 4;
    self.showPickerView = YES;
}

#pragma mark - set


#pragma mark - 
- (void)pushToPickPhoto
{
    if (!self.hadShowPickerView && self.showPickerView) {
        NSLog(@"----- 首次推出照片选择页");
        YSPhotosViewController * photo = [[YSPhotosViewController alloc] initWithAlbum:nil horNum:self.columentNum];
        [self pushViewController:photo animated:NO];
    }
}



@end

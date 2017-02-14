//
//  YSImagePickerController.m
//  YSImagePickerController
//
//  Created by YJ on 17/2/14.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSImagePickerController.h"
#import "YSImagePickerHead.h"

static NSInteger YSTOOLBAR_BTNTAG = 20170214;

@interface YSImagePickerController ()

@property (nonatomic, strong) UIToolbar * bottemToolBar;

@end

@implementation YSImagePickerController

#pragma mark - init
// 选择图片、视频
- (instancetype)initWithMaxCount:(NSInteger)maxCount delegate:(id<YSImagePickerDelegate>)delegate
{
    if (self = [super init]) {
        self.maxCount = maxCount;
        self.delegate = delegate;
    }
    return self;
}

#pragma mark - 
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createToolBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createToolBar
{
    _bottemToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, kNoToolBarHeight, kMainScreenWidth, 50)];
    [self.view addSubview:_bottemToolBar];
    
    _bottemToolBar.barTintColor = [UIColor yellowColor];
    
    UIButton * editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
    editBtn.tag = YSTOOLBAR_BTNTAG + 1;
    [_bottemToolBar addSubview:editBtn];
    
    UIButton * numBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    numBtn.backgroundColor = [UIColor greenColor];
    [numBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    numBtn.userInteractionEnabled = NO;
    numBtn.tag = YSTOOLBAR_BTNTAG + 2;
    [_bottemToolBar addSubview:numBtn];
    
    UIButton * sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.tag = YSTOOLBAR_BTNTAG + 3;
    [_bottemToolBar addSubview:sureBtn];
    
    [_bottemToolBar setItems:@[editBtn, numBtn, sureBtn]];
}

#pragma mark - 
- (void)updateToolBar
{
    
}

#pragma mark - 
- (void)edit
{
    
}

- (void)sure
{

}

@end
